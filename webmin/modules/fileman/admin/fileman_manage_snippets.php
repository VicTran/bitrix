<?
require_once($_SERVER["DOCUMENT_ROOT"]."/webmin/modules/main/include/prolog_admin_before.php");
require_once($_SERVER["DOCUMENT_ROOT"]."/webmin/modules/fileman/prolog.php");
if (!$USER->CanDoOperation('fileman_view_file_structure') && !$USER->CanDoOperation('edit_other_settings'))
	$APPLICATION->AuthForm(GetMessage("ACCESS_DENIED"));

require_once($_SERVER["DOCUMENT_ROOT"]."/webmin/modules/fileman/include.php");
require_once($_SERVER["DOCUMENT_ROOT"]."/webmin/modules/fileman/classes/general/snippets.php");

if(CModule::IncludeModule("compression"))
	CCompress::Disable2048Spaces();

if (isset($_GET['target']) && check_bitrix_sessid())
{
	switch ($_GET['target'])
	{
		case "load":
			CSnippets::LoadList(array(
				'template' => $APPLICATION->UnJSEscape($_GET["templateID"]),
				'bClearCache' => isset($_GET['clear_snippets_cache']) && $_GET['clear_snippets_cache'] == 'Y',
			));
			break;
		case "add":
		case "edit":
			CSnippets::Edit(array(
				'bNew' => $_GET['target'] == 'add',
				'name' => $APPLICATION->UnJSEscape($_REQUEST['name']),
				'path' => isset($_REQUEST['path']) ? $APPLICATION->UnJSEscape($_REQUEST['path']) : false,
				'template' => $APPLICATION->UnJSEscape($_REQUEST['templateID']),
				'site' => $_REQUEST['site'],
				'title' => isset($_REQUEST['title']) ? $APPLICATION->UnJSEscape($_REQUEST['title']) : '',
				'description' => isset($_REQUEST['description']) ? $APPLICATION->UnJSEscape($_REQUEST['description']) : '',
				'code' => isset($_REQUEST['code']) ? $APPLICATION->UnJSEscape($_REQUEST['code']) : '',
				'thumb' => isset($_REQUEST['thumb']) ? $APPLICATION->UnJSEscape($_REQUEST['thumb']) : '',
				'location' => isset($_REQUEST["location"]) ? $APPLICATION->UnJSEscape($_REQUEST["location"]) : false,
				'newGroup' => isset($_REQUEST["new_group"]) ? $APPLICATION->UnJSEscape($_REQUEST["new_group"]) : false,
			));
			break;
		case "delete":
			CSnippets::Delete(array(
				'name' => $APPLICATION->UnJSEscape($_REQUEST['name']),
				'path' => isset($_REQUEST['path']) ? $APPLICATION->UnJSEscape($_REQUEST['path']) : false,
				'template' => $APPLICATION->UnJSEscape($_REQUEST['templateID']),
				'site' => $_REQUEST['site'],
				'thumb' => isset($_REQUEST['thumb']) ? $_REQUEST['thumb'] : ''
			));
			break;
		case "getgroups":
			CSnippets::GetGroups(array('template' => $APPLICATION->UnJSEscape($_REQUEST['templateID'])));
			break;
	}
}

require($_SERVER["DOCUMENT_ROOT"]."/webmin/modules/main/include/epilog_admin_after.php");
?>