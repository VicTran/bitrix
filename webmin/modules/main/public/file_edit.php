<?
define('BX_PUBLIC_MODE', 0); //!!!
require($_SERVER["DOCUMENT_ROOT"]."/webmin/modules/main/include/prolog_admin_before.php");
require($_SERVER["DOCUMENT_ROOT"]."/webmin/modules/main/include/prolog_admin_js.php");

$addUrl = 'lang='.LANGUAGE_ID.($logical == "Y"?'&logical=Y':'');

$bFromComponent = $_REQUEST['from'] == 'main.include' || $_REQUEST['from'] == 'includefile' || $_REQUEST['from'] == 'includecomponent';
$bDisableEditor = !CModule::IncludeModule('fileman') || ($_REQUEST['noeditor'] == 'Y');

if (!($USER->CanDoOperation('fileman_admin_files') || $USER->CanDoOperation('fileman_edit_existent_files')))
	$APPLICATION->AuthForm(GetMessage("ACCESS_DENIED"));

require_once($_SERVER["DOCUMENT_ROOT"]."/webmin/modules/fileman/include.php");

IncludeModuleLangFile($_SERVER["DOCUMENT_ROOT"]."/webmin/modules/fileman/admin/fileman_html_edit.php");
IncludeModuleLangFile($_SERVER["DOCUMENT_ROOT"]."/webmin/modules/main/public/file_edit.php");

$obJSPopup = new CJSPopup("lang=".urlencode($_GET["lang"])."&site=".urlencode($_GET["site"])."&back_url=".urlencode($_GET["back_url"])."&path=".urlencode($_GET["path"])."&name=".urlencode($_GET["name"]), array("SUFFIX"=>($_REQUEST['subdialog'] == 'Y'? 'editor':'')));

$strWarning = "";
$site_template = false;
$rsSiteTemplates = CSite::GetTemplateList($site);
while($arSiteTemplate = $rsSiteTemplates->Fetch())
{
	if(strlen($arSiteTemplate["CONDITION"])<=0)
	{
		$site_template = $arSiteTemplate["TEMPLATE"];
		break;
	}
}

while (($l=strlen($path))>0 && $path[$l-1]=="/")
	$path = substr($path, 0, $l-1);

$bVarsFromForm = false;	// ����, �����������, ������ ����� ������� �� ����� ��� �� ����������� �����
$bSessIDRefresh = false;	// ����, �����������, ����� �� ��������� �� ������ �� �������
$editor_name = (isset($_REQUEST['editor_name'])? $_REQUEST['editor_name'] : 'filesrc_pub');

if (strlen($filename)>0 && ($mess = CFileMan::CheckFileName($filename)) !== true)
{
	$filename2 = $filename;
	$filename = '';
	$strWarning = $mess;
	$bVarsFromForm = true;
}

$path = Rel2Abs("/", $path);
$path = urldecode($path);

$site = CFileMan::__CheckSite($site);
if(!$site)
	$site = CSite::GetSiteByFullPath($_SERVER["DOCUMENT_ROOT"].$path);

$DOC_ROOT = CSite::GetSiteDocRoot($site);
$abs_path = $DOC_ROOT.$path;

$arPath = Array($site, $path);

if(!file_exists($abs_path))
{
	$p = strrpos($path, "/");
	if($p!==false)
	{
		$new = "Y";
		$filename = substr($path, $p+1);
		$path = substr($path, 0, $p);
	}
}

$NEW_ROW_CNT = 1;

$arParsedPath = CFileMan::ParsePath(Array($site, $path), true, false, "", false);
$isScriptExt = in_array(CFileman::GetFileExtension($path), CFileMan::GetScriptFileExt());

//Check access to file
if(
	(
		strlen($new) > 0 &&
		!(
			$USER->CanDoOperation('fileman_admin_files') &&
			$USER->CanDoFileOperation('fm_create_new_file', $arPath)
		)
	)
	||
	(
		strlen($new) < 0 &&
		!(
			$USER->CanDoOperation('fileman_edit_existent_files') &&
			$USER->CanDoFileOperation('fm_edit_existent_file',$arPath)
		)
	)
)
{
	$strWarning = GetMessage("ACCESS_DENIED");
}
else
{
	if(!$USER->IsAdmin() && substr(CFileman::GetFileName($abs_path), 0, 1)==".")
	{
		$strWarning = GetMessage("FILEMAN_FILEEDIT_BAD_FNAME")." ";
		$bEdit = false;
		$bVarsFromForm = true;
		$path = Rel2Abs("/", $arParsedPath["PREV"]);
		$arParsedPath = CFileMan::ParsePath($path, true, false, "", $logical == "Y");
		$abs_path = $DOC_ROOT.$path;
	}
	elseif($new == 'Y')
	{
		$bEdit = false;
	}
	else
	{
		if(!is_file($abs_path))
			$strWarning = GetMessage("FILEMAN_FILEEDIT_FOLDER_EXISTS")." ";
		else
			$bEdit = true;
	}

	$limit_php_access = ($USER->CanDoFileOperation('fm_lpa', $arPath) && !$USER->CanDoOperation('edit_php'));
	if ($limit_php_access)
	{
		//OFP - 'original full path' used for restorin' php code fragments in limit_php_access mode
		if (!isset($_SESSION['arOFP']))
			$_SESSION['arOFP'] = Array();

		if(isset($_POST['ofp_id']))
		{
			$ofp_id = $_POST['ofp_id'];
		}
		else
		{
			$ofp_id = substr(md5($site.'|'.$path),0,8);
			if(!isset($_SESSION['arOFP'][$ofp_id]))
				$_SESSION['arOFP'][$ofp_id] = $path;
		}
	}
}

if(strlen($strWarning) <= 0)
{
	if($bEdit)
	{
		$filesrc_tmp = $APPLICATION->GetFileContent($abs_path);
	}
	else
	{
		$arTemplates = CFileman::GetFileTemplates(LANGUAGE_ID, array($site_template));
		if(strlen($template) > 0)
			for ($i=0; $i < count($arTemplates); $i++)
			{
				if($arTemplates[$i]["file"] == $template)
				{
					$filesrc_tmp = CFileman::GetTemplateContent($arTemplates[$i]["file"],LANGUAGE_ID, array($site_template));
					break;
				}
			}
		else
			$filesrc_tmp = CFileman::GetTemplateContent($arTemplates[0]["file"], LANGUAGE_ID, array($site_template));
	}

	if($_SERVER["REQUEST_METHOD"] == "POST" && $_REQUEST['save'] == 'Y')
	{
		$filesrc = $filesrc_pub;
		if(!check_bitrix_sessid())
		{
			$strWarning = GetMessage("FILEMAN_SESSION_EXPIRED");
			$bVarsFromForm = true;
			$bSessIDRefresh = true;
		}
		elseif((CFileman::IsPHP($filesrc) || $isScriptExt) && !($USER->CanDoOperation('edit_php') || $limit_php_access)) //check rights
		{
			$strWarning = GetMessage("FILEMAN_FILEEDIT_CHANGE");
			$bVarsFromForm = true;
		}
		else
		{
			if($limit_php_access)
			{
				// ofp - original full path :)
				$ofp = $_SESSION['arOFP'][$ofp_id];
				$ofp = Rel2Abs("/", $ofp);
				$abs_ofp = $DOC_ROOT.$ofp;
				$old_filesrc_tmp = $APPLICATION->GetFileContent($abs_ofp);
				$old_res = CFileman::ParseFileContent($old_filesrc_tmp, true);
				$old_filesrc = $old_res["CONTENT"];
				$filesrc = CMain::ProcessLPA($filesrc, $old_filesrc);
			}

			$res = CFileman::ParseFileContent($filesrc_tmp, true);
			$prolog = CFileman::SetTitle($res["PROLOG"], $title);
			for ($i = 0; $i<=$maxind; $i++)
			{
				if(strlen(Trim($_POST["CODE_".$i]))>0)
				{
					if($_POST["CODE_".$i] != $_POST["H_CODE_".$i])
					{
						$prolog = CFileman::SetProperty($prolog, Trim($_POST["H_CODE_".$i]), "");
						$prolog = CFileman::SetProperty($prolog, Trim($_POST["CODE_".$i]), Trim($_POST["VALUE_".$i]));
					}
					else
						$prolog = CFileman::SetProperty($prolog, Trim($_POST["CODE_".$i]), Trim($_POST["VALUE_".$i]));
				}
				else
					$prolog = CFileman::SetProperty($prolog, Trim($_POST["H_CODE_".$i]), "");
			}
			$epilog = $res["EPILOG"];
			$filesrc_for_save = $prolog.$filesrc.$epilog;
		}

		if(strlen($strWarning) <= 0)
		{
			if (!CFileMan::CheckOnAllowedComponents($filesrc_for_save))
			{
				$str_err = $APPLICATION->GetException();
				if($str_err && ($err = $str_err ->GetString()))
					$strWarning .= $err;
				$bVarsFromForm = true;
			}
		}

		if(strlen($strWarning) <= 0)
		{
			// File was created just a second ago
			if (isset($_REQUEST["edit_new_file_undo"]) && strlen($_REQUEST["edit_new_file_undo"]) > 0)
			{
				CUndo::ShowUndoMessage($_REQUEST["edit_new_file_undo"]);
			}
			else
			{
				$arUndoParams = array(
					'module' => 'fileman',
					'undoType' => 'edit_file',
					'undoHandler' => 'CFileman::UndoEditFile',
					'arContent' => array(
						'absPath' => $abs_path,
						'content' => $APPLICATION->GetFileContent($abs_path)
					)
				);
			}

			if(!$APPLICATION->SaveFileContent($abs_path, $filesrc_for_save))
			{
				if($str_err = $APPLICATION->GetException())
				{
					if ($err = $str_err ->GetString())
						$strWarning = $err;

					$bVarsFromForm = true;
					$path = Rel2Abs("/", $arParsedPath["PREV"]);
					$arParsedPath = CFileMan::ParsePath($path, true, false, "", $logical == "Y");
					$abs_path = $DOC_ROOT.$path;
				}

				if (empty($strWarning))
					$strWarning = GetMessage("FILEMAN_FILE_SAVE_ERROR")." ";
			}
		}

		if(strlen($strWarning) <= 0)
		{
			if ($arUndoParams)
				CUndo::ShowUndoMessage(CUndo::Add($arUndoParams));

?>
<script>
<?if($_REQUEST['subdialog'] != 'Y'):?>
	top.BX.showWait();
	top.BX.reload('<?=CUtil::JSEscape($_REQUEST["back_url"])?>', true);
<?else:?>
	if (null != top.structReload)
		top.structReload('<?=urlencode($_REQUEST["path"])?>');
<?endif;?>
	top.<?=$obJSPopup->jsPopup?>.Close();
</script>
<?
		}
		else
		{
?>
<script>
top.CloseWaitWindow();
top.<?=$obJSPopup->jsPopup?>.ShowError('<?=CUtil::JSEscape($strWarning)?>');

var pMainObj = top.GLOBAL_pMainObj['<?=CUtil::JSEscape($editor_name)?>'];
pMainObj.Show(true);
if(top.BX.browser.IsIE() && pMainObj.pUnderFrame)
	pMainObj.pUnderFrame.style.display = "block";

<?if ($bSessIDRefresh):?>
top.BXSetSessionID('<?=CUtil::JSEscape(bitrix_sessid())?>');
<?endif;?>
</script>
<?
		}
		die();
	}
}
else
{
?>
<script>
top.CloseWaitWindow();
top.<?=$obJSPopup->jsPopup?>.ShowError('<?=CUtil::JSEscape($strWarning)?>');

var pMainObj = top.GLOBAL_pMainObj['<?=CUtil::JSEscape($editor_name)?>'];
pMainObj.Show(true);
if(top.BXIsIE() && pMainObj.pUnderFrame)
	pMainObj.pUnderFrame.style.display = "block";
</script>
<?
}

if(!$bVarsFromForm)
{
	$res = CFileman::ParseFileContent($filesrc_tmp, true);
	$filesrc = $res["CONTENT"];

	// ###########  L  P  A  ############
	if ($limit_php_access)
	{
		$arPHP = PHPParser::ParseFile($filesrc);
		$l = count($arPHP);
		if ($l > 0)
		{
			$new_filesrc = '';
			$end = 0;
			$php_count = 0;
			for ($n = 0; $n<$l; $n++)
			{
				$start = $arPHP[$n][0];
				$new_filesrc .= substr($filesrc,$end,$start-$end);
				$end = $arPHP[$n][1];

				//Trim php tags
				$src = $arPHP[$n][2];
				if (SubStr($src, 0, 5) == "<?"."php")
					$src = SubStr($src, 5);
				else
					$src = SubStr($src, 2);
				$src = SubStr($src, 0, -2);

				//If it's Component 2, keep the php code. If it's component 1 or ordinary PHP - than replace code by #PHPXXXX# (XXXX - count of PHP scripts)
				$comp2_begin = '$APPLICATION->INCLUDECOMPONENT(';
				if (strtoupper(substr($src,0, strlen($comp2_begin))) == $comp2_begin)
					$new_filesrc .= $arPHP[$n][2];
				else
					$new_filesrc .= '#PHP'.str_pad(++$php_count, 4, "0", STR_PAD_LEFT).'#';
			}
			$new_filesrc .= substr($filesrc,$end);
			$filesrc = $new_filesrc;
		}
	}

	$bEditProps = (strpos($res["PROLOG"], "prolog_before")>0 || strpos($res["PROLOG"], "header.php")>0);
	$title = $res["TITLE"];

	if((CFileman::IsPHP($filesrc) || $isScriptExt) && !($USER->CanDoOperation('edit_php') || $limit_php_access))
		$strWarning = GetMessage("FILEMAN_FILEEDIT_CHANGE_ACCESS");
}

$obJSPopup->ShowTitlebar(GetMessage('PUBLIC_EDIT_TITLE'.($bFromComponent ? '_COMP' : '')).': '.htmlspecialcharsex($_GET['path']));


$obJSPopup->StartContent(
	array(
		'style' => "0px; height: 500px; overflow: hidden;",
		'class' => "bx-content-editor"
	)
);
?>
</form>
<iframe src="javascript:void(0)" name="file_edit_form_target" height="0" width="0" style="display: none;"></iframe>
<form action="/webmin/admin/public_file_edit.php" name="editor_form" method="post" enctype="multipart/form-data" target="file_edit_form_target" style="margin: 0px; padding: 0px; ">
<?=bitrix_sessid_post()?>
<input type="submit" name="submitbtn" style="display: none;" />
<input type="hidden" name="mode" id="mode" value="public" />
<input type="hidden" name="save" id="save" value="Y" />
<input type="hidden" name="site" id="site" value="<?=htmlspecialchars($site)?>" />
<input type="hidden" name="template" id="template" value="<?echo htmlspecialchars($template)?>" />
<input type="hidden" name="templateID" id="templateID" value="<?echo htmlspecialchars($_REQUEST['templateID'])?>" />
<input type="hidden" name="subdialog" value="<?echo htmlspecialchars($_REQUEST['subdialog'])?>" />
<?if (is_set($_REQUEST, 'back_url')):?>
	<input type="hidden" name="back_url" value="<?=htmlspecialchars($_REQUEST['back_url'])?>" />
<?endif;?>
<?if (is_set($_REQUEST, 'edit_new_file_undo')):?>
	<input type="hidden" name="edit_new_file_undo" value="<?=htmlspecialchars($_REQUEST['edit_new_file_undo'])?>" />
<?endif;?>
<?if(!$bEdit):?>
	<input type="hidden" name="new" id="new" value="Y" />
	<input type="hidden" name="filename" id="filename" value="<?echo htmlspecialchars($filename)?>" />
	<input type="hidden" name="path" id="path" value="<?=htmlspecialchars($path.'/'.$filename)?>" />
<?else:?>
	<input type="hidden" name="title" value="<?=htmlspecialchars($title)?>" />
	<input type="hidden" name="path" id="path" value="<?=htmlspecialchars($path)?>" />
<?endif;?>

<script>
<?=$obJSPopup->jsPopup?>.PARTS.CONTENT.getElementsByTagName('FORM')[0].style.display = 'none'; // hack

function BXFormSubmit()
{
	ShowWaitWindow();
	var obForm = document.forms["editor_form"];
	obForm.elements["submitbtn"].click();
}

function BXSetSessionID(new_sessid)
{
	document.forms.editor_form.sessid.value = new_sessid;
}
</script>

<?
if (!$bDisableEditor):
	CFileman::ShowHTMLEditControl($editor_name, $filesrc, Array(
		"site" => $site,
		"templateID" => $_REQUEST['templateID'],
		"bUseOnlyDefinedStyles" => COption::GetOptionString("fileman", "show_untitled_styles", "N")!="Y",
		"bWithoutPHP" => (!$USER->CanDoOperation('edit_php')),
		"arToolbars" => Array("manage", "standart", "style", "formating", "source", "table"),
		"arTaskbars" => Array("BXComponentsTaskbar", "BXComponents2Taskbar", "BXPropertiesTaskbar", "BXSnippetsTaskbar"),
		"sBackUrl" => $back_url,
		"fullscreen" => false,
		"path" => $path,
		"limit_php_access" => $limit_php_access,
		'height' => '490',
		//'height' => '100%',
		'width' => '100%',
		'light_mode' => true,
	));
?>
<script>
var _bEdit = true;
arEditorFastDialogs['asksave'] = function(pObj)
{
	return {
		title: BX_MESS.EDITOR,
		innerHTML : "<div style='margin-bottom: 20px; padding: 5px;'>" + BX_MESS.DIALOG_EXIT_ACHTUNG + "</div>",
		width: 700,
		height: 130,
		OnLoad: function()
		{
			window.oBXEditorDialog.SetButtons([
				new BX.CWindowButton(
				{
					title: BX_MESS.DIALOG_SAVE_BUT,
					action: function()
					{
						pObj.pMainObj.isSubmited = true;
						if(pObj.params.savetype == 'save')
							BXFormSubmit();
						window.oBXEditorDialog.Close(true);
					}
				}),
				new BX.CWindowButton(
				{
					title: BX_MESS.DIALOG_EXIT_BUT,
					action: function()
					{
						pObj.pMainObj.isSubmited = true;
						<?=$obJSPopup->jsPopup?>.CloseDialog();
						pObj.pMainObj.oPublicDialog.Close(true);
					}
				}),
				window.oBXEditorDialog.btnCancel
			]);

			BX.addClass(window.oBXEditorDialog.PARTS.CONTENT, "bxed-dialog");
		}
	};
};

function _BXOnBeforeCloseDialog()
{
	var pMainObj = GLOBAL_pMainObj['<?=CUtil::JSEscape($editor_name)?>'];

	// We need to ask user
	if (pMainObj.IsChanged() && !pMainObj.isSubmited)
	{
		pMainObj.oPublicDialog.DenyClose();
		pMainObj.OpenEditorDialog("asksave", false, 600, {window: window, savetype: _bEdit ? 'save' : 'saveas', popupMode: true}, true);
	}
}

function CheckEditorFinish()
{
	var pMainObj = GLOBAL_pMainObj['<?=CUtil::JSEscape($editor_name)?>'];
	if (!pMainObj.bLoadFinish)
		return setTimeout('CheckEditorFinish()', 100);

	<?=$obJSPopup->jsPopup?>.AllowClose();
	jsUtils.addEvent(pMainObj.pEditorDocument, "keypress", window.JCPopup_OnKeyPress);

	pMainObj.oPublicDialog = BX.WindowManager.Get();
	//var wnd = BX.WindowManager.Get();
	BX.addClass(pMainObj.oPublicDialog.PARTS.CONTENT, "bx-editor-dialog-cont");
	//BX.WindowManager.disableKeyCheck();
	pMainObj.oPublicDialog.AllowClose();

	if (BX.browser.IsIE())
	{
		pMainObj.pWnd.firstChild.tBodies[0].rows[0].style.height = '1px';
		var sftbl;
		if (sftbl = BX.findChild(pMainObj.oPublicDialog.PARTS.CONTENT, {tagName: "TABLE"}))
		{
			sftbl.cellSpacing = 0;
			sftbl.cellPadding = 0;
		}
	}

	var onWinResizeExt = function(Params)
	{
		var
			h = parseInt(Params.height) - 2,
			w = parseInt(Params.width) - 10;

		//if (BX.browser.IsIE())
		//	w += 2;

		pMainObj.pWnd.style.height = h + "px";
		pMainObj.pWnd.style.width = w + "px";

		var d1 = 86;
		BX.findParent(pMainObj.cEditor, {tagName: "TABLE"}).style.height = (h - d1) + "px";

		pMainObj.arTaskbarSet[2]._SetTmpClass(true);
		pMainObj.arTaskbarSet[2].Resize(false, false, false);
		pMainObj.arTaskbarSet[3].Resize(false, false, false);

		if (window._SetTmpClassInterval)
			clearInterval(window._SetTmpClassInterval);
		window._SetTmpClassInterval = setTimeout(function(){pMainObj.arTaskbarSet[2]._SetTmpClass(false);}, 300);
	}
	onWinResizeExt(pMainObj.oPublicDialog.GetInnerPos());

	BX.addCustomEvent(pMainObj.oPublicDialog, 'onWindowResizeExt', onWinResizeExt);
	BX.addCustomEvent(pMainObj.oPublicDialog, 'onBeforeWindowClose', _BXOnBeforeCloseDialog);
}

CheckEditorFinish();
<? if (COption::GetOptionString("fileman", "htmleditor_fullscreen", "N") == "Y"):?>
BX.WindowManager.Get().__expand();
<?endif;?>

</script>
<?
else: //if ($bDisableEditor)
?>
<textarea name="<?=htmlspecialchars($editor_name)?>" id="<?=htmlspecialchars($editor_name)?>" style="height: 99%; width: 100%;"><?=htmlspecialcharsex($filesrc)?></textarea>
<script type="text/javascript">
var border = null, ta = null, wnd = BX.WindowManager.Get();

function TAResize(data)
{
	if (null == ta) ta = BX('<?=htmlspecialchars($editor_name)?>');
	if (null == border) border = parseInt(BX.style(ta, 'border-left-width')) + parseInt(BX.style(ta, 'border-right-width'));
	if (isNaN(border)) border = 0;

	if (data.height) ta.style.height = (data.height - border) + 'px';
	if (data.width) ta.style.width = (data.width - border) + 'px';
}

BX.addCustomEvent(wnd, 'onWindowResizeExt', TAResize);
TAResize(wnd.GetInnerPos());
</script>
<?
endif; //if (!$bDisableEditor)
$obJSPopup->StartButtons();
?>
	<input type="button" id="btn_popup_save" name="btn_popup_save" value="<?=GetMessage("JSPOPUP_SAVE_CAPTION")?>" onclick="BXFormSubmit();" title="<?=GetMessage("JSPOPUP_SAVE_CAPTION")?>" />
<?
$obJSPopup->ShowStandardButtons(array('cancel'));
$obJSPopup->EndButtons();
die();
require($_SERVER["DOCUMENT_ROOT"]."/webmin/modules/main/include/epilog_admin_js.php");
?>