<?
require_once($_SERVER["DOCUMENT_ROOT"]."/webmin/modules/main/include/prolog_admin_before.php");
require_once($_SERVER["DOCUMENT_ROOT"]."/webmin/modules/fileman/prolog.php");

if (!$USER->CanDoOperation('fileman_view_file_structure') && !$USER->CanDoOperation('edit_other_settings'))
	$APPLICATION->AuthForm(GetMessage("ACCESS_DENIED"));
require_once($_SERVER["DOCUMENT_ROOT"]."/webmin/modules/fileman/include.php");

if(CModule::IncludeModule("compression"))
	CCompress::Disable2048Spaces();

global $thirdLevelId;
$thirdLevelId = 0;

function handleComp2Tree()
{
	$allowed_components = trim(COption::GetOptionString('fileman', "~allowed_components", ''));
	// Name filter exists
	if (strlen($allowed_components) > 0)
	{
		$arAC = explode("\n",$allowed_components);
		$arAC = array_unique($arAC);
		$arAllowedComponents = Array();
		foreach ($arAC as $f)
		{
			$f = preg_replace("/\s/is", "", $f);
			$f = preg_replace("/\./is", "\\.", $f);
			$f = preg_replace("/\*/is", ".*", $f);
			$arAllowedComponents[] = '/^'.$f.'$/';
		}
		$components_namespace = 'webmin';
		$mask = substr(md5($allowed_components), 2, 6);
	}
	else
	{
		$arAllowedComponents = false;
		$components_namespace = false;
		$mask = 0;
	}

	// *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *
	global $CACHE_MANAGER;
	$cache = Array();
	$arTree = false;
	$lang = isset($_REQUEST['lang']) ? $_REQUEST['lang'] : LANGUAGE_ID;
	$cache_name = 'fileman_component_tree_array_'.$lang;
	if (isset($_GET['clear_comp2_cache']) && $_GET['clear_comp2_cache'] == 'Y')
		$CACHE_MANAGER->CleanDir("fileman_component_tree_array");

	$ttl = 10*24*60*60; // Time of life
	if($CACHE_MANAGER->Read($ttl, $cache_name, "fileman_component_tree_array"))
	{
		$cache = $CACHE_MANAGER->Get($cache_name);
		if (isset($cache[$mask]))
			$arTree = $cache[$mask];
	}

	if ($arTree === false)
	{
		$arTree = $cache[$mask] = CComponentUtil::GetComponentsTree($components_namespace, $arAllowedComponents);
		$CACHE_MANAGER->Set($cache_name, $cache);
	}
	// *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *

	if (isset($arTree['#']))
		handleChildren($arTree['#'],'');
}

function handleChildren($arEls, $path)
{
	foreach ($arEls as $elName => $arEl)
	{
		if (strpos($path, ",")!==false)
		{
			if (isset($arEl['*']))
			{
				$thirdLevelName = '__bx_thirdLevel_'.$GLOBALS["thirdLevelId"];
				$GLOBALS["thirdLevelId"]++;
				foreach ($arEl['*'] as $cN => $arC)
					pushElement($path, $cN, $arC['TITLE'], false, $arC['ICON'], $arC['COMPLEX'], '{DESCRIPTION : \''.CUtil::JSEscape($arC['DESCRIPTION']).'\'}',$thirdLevelName,$arC['SCREENSHOT']);
			}
			continue;
		}

		$realPath = (($path=='') ? $elName : $path.','.$elName);
		pushElement($path,$elName,$arEl['@']['NAME'],true,'','N');
		if (isset($arEl['#']))
			handleChildren($arEl['#'],$realPath);

		if (isset($arEl['*']))
			pushComponents($arEl['*'],$realPath);
	}
}

function pushComponents($arComponents, $path)
{
	foreach ($arComponents as $compName => $arComponent)
		pushElement($path,$compName,$arComponent['TITLE'],false,$arComponent['ICON'],$arComponent['COMPLEX'],'{DESCRIPTION : \''.CUtil::JSEscape($arComponent['DESCRIPTION']).'\'}',false,$arComponent['SCREENSHOT']);
}


function pushElement($path, $name, $title, $isGroup, $icon, $complex, $params = false, $thirdLevelName = false, $screenshots = array())
{
	$len = count($screenshots);
	if ($len>0)
	{
		$sScreenshots = "[";
		for ($i = 0; $i < $len; $i++)
			$sScreenshots .= '\''.CUtil::JSEscape($screenshots[$i]).'\',';

		$sScreenshots = substr($sScreenshots, 0, -1);
		$sScreenshots .= "]";
	}
	else
	{
		$sScreenshots = false;
	}
?>
a.push({
	path: '<?=$path;?>',
	name: '<?= CUtil::JSEscape($name);?>',
	title: '<?= CUtil::JSEscape($title);?>',
	isGroup: <?=(($isGroup) ? 'true' : 'false');?>,
	icon: '<?=$icon;?>',
	complex: '<?=$complex;?>',
	params: <?=(($params===false) ? '[]' : $params);?>,
<?if($sScreenshots !== false):?>	screenshots: <?= $sScreenshots.","?><?endif;?>
	thirdlevel: '<? echo(($thirdLevelName===false) ? '' : CUtil::JSEscape($thirdLevelName));?>'
});
<?
}

if (isset($_GET['load_tree']) && $_GET['load_tree'] == 'Y'):?>
<script>
var a = [];
<?handleComp2Tree();?>
window.arComp2Elements = a;
</script>
<?endif;
require($_SERVER["DOCUMENT_ROOT"]."/webmin/modules/main/include/epilog_admin_after.php");
?>