<?
require_once($_SERVER["DOCUMENT_ROOT"]."/webmin/modules/main/include/prolog_admin_before.php");
require_once($_SERVER["DOCUMENT_ROOT"]."/webmin/modules/fileman/prolog.php");
if (!$USER->CanDoOperation('fileman_edit_existent_files') || !check_bitrix_sessid())
	$APPLICATION->AuthForm(GetMessage("ACCESS_DENIED"));
require_once($_SERVER["DOCUMENT_ROOT"]."/webmin/modules/fileman/include.php");

if(CModule::IncludeModule("compression"))
	CCompress::Disable2048Spaces();

if (!isset($_REQUEST['target']) || !isset($_REQUEST['edname']))
	die();

$edname =  $_REQUEST['edname'];
$target =  $_REQUEST['target'];

// echo "<pre>";
// print_r($_REQUEST);
// echo "</pre><hr>";

if ($target == 'toolbars' &&  isset($_POST['tlbrset']))
{
	if (isset($_REQUEST['rs_tlbrs']))
		CUserOptions::SetOption("fileman", "rs_toolbar_".$edname, ($_REQUEST['rs_tlbrs']=="N" ? "N" : "Y"));

	$tlbrset = $_POST['tlbrset'];
	$resultString = "";
	$_string = '';
	foreach($tlbrset as $tlbrname => $tlbr)
	{
		$resultString .= $tlbrname.":";
		$resultString .= $tlbr['show'].",";
		$resultString .= $tlbr['docked'].",";
		$resultString .= "[";
		foreach($tlbr['position'] as $tlbrpos)
			$resultString .= (substr($tlbrpos,-2)=="px" ? substr($tlbrpos,0,-2) : $tlbrpos).";";
		$resultString .= "]";
		$resultString .= "||";
	}
	$resultString = substr($resultString,0,-2);

	CUserOptions::SetOption("fileman", "toolbar_settings_".$edname, _addslashes($resultString));
}

if (isset($_REQUEST['tooltips']) && $target == 'tooltips')
	CUserOptions::SetOption("fileman", "show_tooltips".$edname, $_REQUEST['tooltips'] == "N" ? "N" : "Y");

if (isset($_REQUEST['visual_effects']) && $target == "visual_effects")
	CUserOptions::SetOption("fileman", "visual_effects".$edname, ($_REQUEST['visual_effects'] == "N" ? "N" : "Y"));

if (isset($_REQUEST['render_components']) && $target == 'render_components')
	CUserOptions::SetOption("fileman", "render_components", $_REQUEST['render_components'] == "Y");

if ($target == 'taskbars')
{
	// Taskbars
	if (isset($_POST['tskbrset']))
	{
		$taskbars = $_POST['tskbrset'];
		$res = array();
		foreach($taskbars as $name => $taskbar)
		{
			if ($taskbar['set'] != 2)
				$taskbar['set'] = 3;

			$res[$name] = array(
				'show' => $taskbar['show'] == "true",
				'set' => $taskbar['set'],
				'active' => $taskbar['active'] == "true"
			);
		}

		CUserOptions::SetOption("fileman", "taskbar_settings_".$edname, serialize($res));
	}

	// Taskbarsets
	if (isset($_POST['tskbrsetset']))
	{
		$tskbrsetset = $_POST['tskbrsetset'];
		$res = array();
		foreach($tskbrsetset as $iNum => $tskbrset)
		{
			if ($iNum != 2)
				$iNum = 3;

			$res[$iNum] = array(
				'show' => $tskbrset['show'] == "true",
				'size' => intVal($tskbrset['size'])
			);
		}

		CUserOptions::SetOption("fileman", "taskbarset_settings_".$edname, serialize($res));
	}
}

if ($target == 'get_all')
{
	//Get toolbar settings
	$toolbar_settings = stripslashes(CUserOptions::GetOption("fileman", "toolbar_settings_".$edname));

	if ($toolbar_settings)
		getToolbarSettings($toolbar_settings);

	//Get taskbar settings
	$taskbars = CUserOptions::GetOption("fileman", "taskbar_settings_".$edname, false);
	if ($taskbars !== false)
		$taskbars = unserialize($taskbars);

	?><script><?
	if (is_array($taskbars))
	{
		?>window.arTaskbarSettings = [];<?
		foreach($taskbars as $tname => $tskbr)
		{
			// Display settings
			?>window.arTaskbarSettings["<?=$tname;?>"] = {show: <?= $tskbr['show'] ? 'true' : 'false'?>, set: <?= $tskbr['set'] == 2 ? 2 : 3?>, active: <?= $tskbr['active'] ? 'true' : 'false'?>};<?
		}
	}
	?></script><?

	//Get taskbar settings
	//$taskbar_settings = stripslashes(CUserOptions::GetOption("fileman", "taskbar_settings_".$edname));
	//$rs_tskbrs = stripslashes(CUserOptions::GetOption("fileman", "rs_taskbar_".$edname));

	//if ($taskbar_settings)
	//	getTaskbarSettings($taskbar_settings, $rs_tskbrs);

	//Get taskbarset settings
	?><script><?
	$taskbarset = CUserOptions::GetOption("fileman", "taskbarset_settings_".$edname, false);
	if ($taskbarset !== false)
		$taskbarset = unserialize($taskbarset);

	if (is_array($taskbarset))
	{
		?>window.arTBSetsSettings = [];<?
		foreach($taskbarset as $iNum => $tskbrset)
		{
			if ($iNum != 2)
				$iNum = 3;
			?>window.arTBSetsSettings["<?= intVal($iNum)?>"] = {show: <?= $tskbrset['show'] ? 'true' : 'false'?>, size: <?= intVal($tskbrset['size'])?>};
			<?
		}
	}
	?></script><?
	// $taskbarset = stripslashes(CUserOptions::GetOption("fileman", "taskbarset_settings_".$edname));
	// if ($taskbarset)
		// getTaskbarsetSettings($taskbarset);

	$show_tooltips = CUserOptions::GetOption("fileman", "show_tooltips".$edname, "Y");
	$visualEffects = CUserOptions::GetOption("fileman", "visual_effects".$edname, "Y");

	displayJSAddSett($show_tooltips, $visualEffects);
}

if ($target == 'unset')
{
	CUserOptions::DeleteOption("fileman", "toolbar_settings_".$edname);
	CUserOptions::DeleteOption("fileman", "rs_toolbar_".$edname);
	CUserOptions::DeleteOption("fileman", "taskbar_settings_".$edname);
	CUserOptions::DeleteOption("fileman", "rs_taskbar_".$edname);
	CUserOptions::DeleteOption("fileman", "taskbarset_settings_".$edname);
	CUserOptions::DeleteOption("fileman", "show_tooltips".$edname);
	CUserOptions::DeleteOption("fileman", "visual_effects".$edname);
}

function displayJSAddSett($tooltips, $visualEffects)
{?>
<script>
window.__show_tooltips = <?echo $tooltips == "N" ? "false" : "true";?>;
window.__visual_effects = <?echo $visualEffects == "N" ? "false" : "true";?>;
</script>
<?}

function displayJSToolbar($tlbrname,$show,$docked,$arPos)
{
	?>
	<script>
	var _ar = [];
	_ar.show = <?echo($show == 'true' ? 'true' : 'false');?>;
	_ar.docked = <?echo($docked=='true' ? 'true' : 'false');?>;
	<?if ($docked=='true'):?>
		_ar.position = [<?echo$arPos[0];?>,<?echo$arPos[1];?>,<?echo$arPos[2];?>];
	<?else:?>
		_ar.position = {
			x : '<?echo(substr($arPos[0],-2)=="px" ? substr($arPos[0],0,-2) : $arPos[0]);?>',
			y : '<?echo(substr($arPos[1],-2)=="px" ? substr($arPos[1],0,-2) : $arPos[1]);?>'
		};
	<?endif;?>
	window.arToolbarSettings["<?echo$tlbrname;?>"] = _ar;
	</script>
	<?
}

function displayJSTaskbar($tskbrname,$show,$docked,$arPos,$auto)
{
	?>
	<script>
	var _ar = [];
	_ar.show = <?echo(($show=='true' && $auto!='true') ? 'true' : 'false');?>;
	_ar.docked = <?echo($docked=='true' ? 'true' : 'false');?>;
	<?if ($docked=='true'):?>
		_ar.position = [<?=$arPos[0];?>,<?=$arPos[1];?>,<?=$arPos[2];?>];
	<?else:?>
		_ar.position = {
			x : '<?echo substr($arPos[0],-2)=="px" ? substr($arPos[0],0,-2) : $arPos[0];?>',
			y : '<?echo substr($arPos[1],-2)=="px" ? substr($arPos[1],0,-2) : $arPos[1];?>'
		};
	<?endif;?>
	<?if ($auto!=''):?>
		_ar.auto = <?echo($auto=='true' ? 'true' : 'false');?>;
	<?endif;?>
	window.arTaskbarSettings["<?=$tskbrname;?>"] = _ar;
	</script>
	<?
}


function _addslashes($str)
{
	$pos = strpos(strtolower($str), "</script");
	if ($pos!==FALSE)
		$str = str_replace("</script","&lt;/script",$str);

	$pos2 = strpos(strtolower($str), "\n");
	if ($pos2!==FALSE)
	{
		$str = str_replace("\r","",$str);
		$str = str_replace("\n","\\n",$str);
	}
	return CUtil::addslashes($str);
}


function getToolbarSettings($settings,$rs_tlbrs)
{
	?>
	<script>
	window.arToolbarSettings = [];
	window.RS_toolbars = <?echo($rs_tlbrs=="N" ? "false" : "true");?>;
	</script>
	<?
	$res = explode("||", $settings);
	$len = count($res);

	for ($i=0; $i<$len; $i++)
	{
		$tmp = explode(":", $res[$i]);
		$tlbrname = $tmp[0];
		$tmp2 = explode(",", $tmp[1]);
		$show = $tmp2[0];
		$docked = $tmp2[1];
		$position = explode(";",substr($tmp2[2],1,-1));
		displayJSToolbar($tlbrname,$show,$docked,$position);
	}
}

function getTaskbarSettings($settings,$rs_tskbrs)
{
	?>
	<script>
	window.arTaskbarSettings = [];
	</script>
	<?
	$res = explode("||", $settings);
	$len = count($res);

	for ($i=0; $i<$len; $i++)
	{
		$tmp = explode(":", $res[$i]);
		$tskbrname = $tmp[0];
		$tmp2 = explode(",", $tmp[1]);
		$show = $tmp2[0];
		$docked = $tmp2[1];
		$position = explode(";",substr($tmp2[2],1,-1));
		$auto = ($tmp2[3]) ? $tmp2[3] : '';
		displayJSTaskbar($tskbrname,$show,$docked,$position,$auto);
	}
}
?>