<?
/*
##############################################
# Bitrix Site Manager                        #
# Copyright (c) 2002-2010 Bitrix             #
# http://www.bitrixsoft.com                  #
# mailto:admin@bitrixsoft.com                #
##############################################
*/

if(!defined("B_PROLOG_INCLUDED") || B_PROLOG_INCLUDED!==true) die();
IncludeModuleLangFile(__FILE__);

function Panel_Sort($a, $b)
{
	if($a["MAIN_SORT"] == $b["MAIN_SORT"])
	{
		if($a["SORT"] == $b["SORT"])
			return 0;
		return ($a["SORT"] < $b["SORT"]? -1 : 1);
	}
	return ($a["MAIN_SORT"] < $b["MAIN_SORT"]? -1 : 1);
}

function __PanelMenuSort($a, $b) 
{
	if (isset($a["SORT"]) && isset($b["SORT"]))
		return strcmp($a["SORT"], $b["SORT"]);	
	else if (isset($a["SORT"]) && !isset($b["SORT"]))
		return -1;
	else if (!isset($a["SORT"]) && isset($b["SORT"]))		
		return 1;
	else
		return 0;
}


function GetStandardButtons()
{
	global $USER, $APPLICATION, $DB;

	//Check permissions functions
	function IsCanCreatePage($currentDirPath, $documentRoot, $filemanExists)
	{
		if (!is_dir($documentRoot.$currentDirPath) || !$GLOBALS["USER"]->CanDoFileOperation("fm_create_new_file", Array(SITE_ID, $currentDirPath)))
			return false;

		if ($filemanExists)
			return $GLOBALS["USER"]->CanDoOperation("fileman_admin_files");

		return true;
	}

	function IsCanCreateSection($currentDirPath, $documentRoot, $filemanExists)
	{
		if (!is_dir($documentRoot.$currentDirPath) ||
			!$GLOBALS["USER"]->CanDoFileOperation("fm_create_new_folder", Array(SITE_ID, $currentDirPath)) ||
			!$GLOBALS["USER"]->CanDoFileOperation("fm_create_new_file", Array(SITE_ID, $currentDirPath)))
			return false;

		if ($filemanExists)
			return ($GLOBALS["USER"]->CanDoOperation("fileman_admin_folders") && $GLOBALS["USER"]->CanDoOperation("fileman_admin_files"));

		return true;
	}

	function IsCanEditPage($currentFilePath, $documentRoot, $filemanExists)
	{
		if (!is_file($documentRoot.$currentFilePath) || !$GLOBALS["USER"]->CanDoFileOperation("fm_edit_existent_file",Array(SITE_ID, $currentFilePath)))
			return false;

		if ($filemanExists)
		{
			if (in_array(GetFileExtension($currentFilePath), GetScriptFileExt()) && !$GLOBALS["USER"]->CanDoFileOperation('fm_lpa', Array(SITE_ID, $currentFilePath)) && !$GLOBALS["USER"]->CanDoOperation('edit_php'))
				return false;

			return ($GLOBALS["USER"]->CanDoOperation("fileman_admin_files") && $GLOBALS["USER"]->CanDoOperation("fileman_edit_existent_files"));
		}

		return true;
	}

	function IsCanEditSection($currentDirPath, $filemanExists)
	{
		if (!$GLOBALS["USER"]->CanDoFileOperation("fm_edit_existent_folder", Array(SITE_ID, $currentDirPath)))
			return false;

		if ($filemanExists)
			return ($GLOBALS["USER"]->CanDoOperation("fileman_edit_existent_folders") && $GLOBALS["USER"]->CanDoOperation("fileman_admin_folders"));

		return true;
	}

	function IsCanEditPermission($currentFilePath, $documentRoot, $filemanExists)
	{
		if (!file_exists($documentRoot.$currentFilePath) ||
			!$GLOBALS["USER"]->CanDoFileOperation("fm_edit_existent_folder",Array(SITE_ID, $currentFilePath)) ||
			!$GLOBALS["USER"]->CanDoFileOperation("fm_edit_permission",Array(SITE_ID, $currentFilePath)))
				return false;

		if ($filemanExists)
			return ($GLOBALS["USER"]->CanDoOperation("fileman_edit_existent_folders") && $GLOBALS["USER"]->CanDoOperation("fileman_admin_folders"));

		return true;
	}

	function IsCanDeletePage($currentFilePath, $documentRoot, $filemanExists)
	{
		if (!is_file($documentRoot.$currentFilePath) || !$GLOBALS["USER"]->CanDoFileOperation("fm_delete_file",Array(SITE_ID, $currentFilePath)))
			return false;

		if ($filemanExists)
			return ($GLOBALS["USER"]->CanDoOperation("fileman_admin_files"));

		return true;
	}



	if (isset($_SERVER["REAL_FILE_PATH"]) && $_SERVER["REAL_FILE_PATH"] != "")
	{
		$currentDirPath = dirname($_SERVER["REAL_FILE_PATH"]);
		$currentFilePath = $_SERVER["REAL_FILE_PATH"];
	}
	else
	{
		$currentDirPath = $APPLICATION->GetCurDir();
		$currentFilePath = $APPLICATION->GetCurPage(true);
	}

	$encCurrentDirPath = urlencode($currentDirPath);
	$encCurrentFilePath = urlencode($currentFilePath);
	$encRequestUri = urlencode($_SERVER["REQUEST_URI"]);
	$encSiteTemplateId = urlencode(SITE_TEMPLATE_ID);

	$documentRoot = CSite::GetSiteDocRoot(SITE_ID);
	$filemanExists = IsModuleInstalled("fileman");

	//create button
	$defaultUrl = "";
	$bCanCreatePage = IsCanCreatePage($currentDirPath, $documentRoot, $filemanExists);
	$bCanCreateSection = IsCanCreateSection($currentDirPath, $documentRoot, $filemanExists);

	if ($bCanCreatePage || $bCanCreateSection)
	{
		require_once($_SERVER["DOCUMENT_ROOT"].BX_ROOT."/modules/main/admin_tools.php");
		//create page from new template
		$arActPageTemplates = CPageTemplate::GetList(array(SITE_TEMPLATE_ID));
		//create page from old template
		$arPageTemplates = GetFileTemplates(SITE_ID, array(SITE_TEMPLATE_ID));
	}

	// CREATE PAGE button and submenu
	$arMenu = Array();
	if ($bCanCreatePage)
	{
		$defaultUrl = $APPLICATION->GetPopupLink(
			Array(
				"URL"=>"/webmin/admin/public_file_new.php?lang=".LANGUAGE_ID."&site=".SITE_ID."&templateID=".$encSiteTemplateId.
					"&path=".$encCurrentDirPath."&back_url=".$encRequestUri,
				"PARAMS"=> Array("min_width"=>450, "min_height" => 250)
			)
		);
	
		$arMenu[] = Array(
			"TEXT"=>GetMessage("top_panel_create_page"),
			"TITLE"=>GetMessage("top_panel_create_page_title"),
			"ICON"=>"panel-new-file",
			"ACTION"=> $defaultUrl,
			"DEFAULT"=>true,
			"SORT" => 10
		);
		
		$arMenu[] = Array("SEPARATOR"=>true, "SORT" => 15);		

		//templates menu for pages
		$arSubmenu = array();
		if(!empty($arActPageTemplates))
		{
			foreach($arActPageTemplates as $pageTemplate)
			{
				if($pageTemplate['type'] == '' || $pageTemplate['type'] == 'page')
				{
					$arSubmenu[] = array(
						"TEXT"=>"<b>".$pageTemplate['name']."</b>".($pageTemplate['description'] <> ''? "<br>".$pageTemplate['description']:""),
						"TITLE"=>GetMessage("top_panel_template")." ".$pageTemplate['file'],
						"ICON"=>($pageTemplate['icon'] == ''? "panel-new-file-template":""),
						"IMAGE"=>($pageTemplate['icon'] <> ''? $pageTemplate['icon']:""),
						"ACTION"=> str_replace("public_file_new.php?", "public_file_new.php?wiz_template=".urlencode($pageTemplate['file'])."&", $defaultUrl),
					);
				}
			}
		}

		if(!empty($arPageTemplates) && (!empty($arSubmenu) || count($arPageTemplates)>1))
		{
			foreach($arPageTemplates as $pageTemplate)
				$arSubmenu[] = array(
					"TEXT"=>$pageTemplate['name'],
					"TITLE"=>GetMessage("top_panel_template")." ".$pageTemplate['file'],
					"ICON"=>"panel-new-file-template",
					"ACTION"=> str_replace("public_file_new.php?", "public_file_new.php?page_template=".urlencode($pageTemplate['file'])."&", $defaultUrl),
				);
		}


		//page from template
		if($bCanCreatePage && !empty($arSubmenu))
		{
			$arMenu[] = array(
				"TEXT"=>GetMessage("top_panel_create_from_template"),
				"TITLE"=>GetMessage("top_panel_create_from_template_title"),
				"ICON"=>"panel-new-file-template",
				"MENU"=>$arSubmenu,
				"SORT" => 20
			);
		}
	}
	
	if (!empty($arMenu))
	{
		$APPLICATION->AddPanelButton(Array(
			"HREF"=> ($defaultUrl == "" ? "" : "javascript:".$defaultUrl),
			'TYPE' => 'BIG',
			"ID"=>"create",
			"ICON"=>"bx-panel-create-page-icon",
			"ALT"=>GetMessage("top_panel_create_title"),
			"TEXT"=> GetMessage("top_panel_create_new"),//GetMessage("top_panel_create"),
			"MAIN_SORT"=>"100",
			"SORT"=>10,
			"MENU"=> $arMenu,
			"RESORT_MENU" => true
		));
	}
	
	// CREATE SECTION button and submenu
	$arMenu = array();
	if ($bCanCreateSection)
	{
		$defaultUrl = $APPLICATION->GetPopupLink(Array(
				"URL"=>"/webmin/admin/public_file_new.php?lang=".LANGUAGE_ID."&site=".SITE_ID."&templateID=".$encSiteTemplateId.
							"&newFolder=Y&path=".$encCurrentDirPath."&back_url=".$encRequestUri,
				"PARAMS"=>Array("min_width"=>450, "min_height" => 250)));
	
		$arMenu[] = Array(
			"TEXT"=>GetMessage("top_panel_create_folder"),
			"TITLE"=>GetMessage("top_panel_create_folder_title"),
			"ICON"=>"panel-new-folder",
			'DEFAULT'=> true,
			"ACTION"=> $defaultUrl,
			"SORT"=>10,
		);

		$arMenu[] = Array("SEPARATOR"=>true, "SORT"=>15);
		
		//templates menu for sections
		$arSectSubmenu = array();
		if(!empty($arActPageTemplates))
		{
			foreach($arActPageTemplates as $pageTemplate)
			{
				if($pageTemplate['type'] == '' || $pageTemplate['type'] == 'section')
				{
					$arSectSubmenu[] = array(
						"TEXT"=>"<b>".$pageTemplate['name']."</b>".($pageTemplate['description'] <> ''? "<br>".$pageTemplate['description']:""),
						"TITLE"=>GetMessage("top_panel_template")." ".$pageTemplate['file'],
						"ICON"=>($pageTemplate['icon'] == ''? "panel-new-file-template":""),
						"IMAGE"=>($pageTemplate['icon'] <> ''? $pageTemplate['icon']:""),
						"ACTION"=> str_replace("public_file_new.php?", "public_file_new.php?newFolder=Y&wiz_template=".urlencode($pageTemplate['file'])."&", $defaultUrl),
					);
				}
			}
		}

		if(!empty($arPageTemplates) && (!empty($arSectSubmenu) || count($arPageTemplates)>1))
		{
			if(!empty($arSectSubmenu))
				$arSectSubmenu[] = array("SEPARATOR"=>true);

			foreach($arPageTemplates as $pageTemplate)
				$arSectSubmenu[] = array(
					"TEXT"=>$pageTemplate['name'],
					"TITLE"=>GetMessage("top_panel_template")." ".$pageTemplate['file'],
					"ICON"=>"panel-new-file-template",
					"ACTION"=> str_replace("public_file_new.php?", "public_file_new.php?newFolder=Y&page_template=".urlencode($pageTemplate['file'])."&", $defaultUrl),
				);

		}

		//section from template
		if($bCanCreateSection && !empty($arSectSubmenu))
		{
			$arMenu[] = array(
				"TEXT"=>GetMessage("top_panel_create_folder_template"),
				"TITLE"=>GetMessage("top_panel_create_folder_template_title"),
				"ICON"=>"panel-new-folder-template",
				"MENU"=>$arSectSubmenu,
				"SORT"=>20,
			);
		}
	}
	
	if (!empty($arMenu))
	{
		$APPLICATION->AddPanelButton(Array(
			"HREF"=> ($defaultUrl == "" ? "" : "javascript:".$defaultUrl),
			'TYPE' => 'BIG',
			"ID"=>"create_section",
			"ICON"=>"bx-panel-create-section-icon",
			"ALT"=>GetMessage("top_panel_create_title"),
			"TEXT"=>GetMessage("top_panel_create_folder_new"),//GetMessage("top_panel_create"),
			"MAIN_SORT"=>"100",
			"SORT"=>20,
			"MENU"=> $arMenu,
			"RESORT_MENU" => true
		));
	}
	
	
	// EDIT PAGE button and submenu
	$defaultUrl = "";
	$arMenu = Array();
	if (IsCanEditPage($currentFilePath, $documentRoot, $filemanExists))
	{
		$defaultUrl = $APPLICATION->GetPopupLink(Array(
			"URL"=> "/webmin/admin/public_file_edit.php?lang=".LANGUAGE_ID."&path=".$encCurrentFilePath."&site=".SITE_ID."&back_url=".$encRequestUri."&templateID=".$encSiteTemplateId,
			"PARAMS"=>array(
				"width"=>780,
				"height"=>570,
				"resizable"=>true,
				"min_width"=> 780,
				"min_height"=> 400
			))
		);

		$arMenu[] = Array(
			"TEXT"=>GetMessage("top_panel_edit_page"),
			"TITLE"=>GetMessage("top_panel_edit_page_title"),
			"ICON"=>"panel-edit-visual",
			"ACTION"=> $defaultUrl,
			"DEFAULT"=>true,
			"SORT"=>10,
		);
		
		$arMenu[] = Array("SEPARATOR"=>true, "SORT"=>15);

		$arMenu[] = Array("SEPARATOR" => true, "SORT"=>45);
		$arMenu[] = Array(
			"TEXT"=>GetMessage("top_panel_edit_page_html"),
			"TITLE"=>GetMessage("top_panel_edit_page_html_title"),
			"ICON"=>"panel-edit-text",
			"ACTION"=>$APPLICATION->GetPopupLink(Array(
				"URL"=>"/webmin/admin/public_file_edit.php?lang=".LANGUAGE_ID."&noeditor=Y&path=".$encCurrentFilePath."&site=".SITE_ID."&back_url=".$encRequestUri,
				"PARAMS"=>array("width"=>780, "height"=>570, "resize"=>true))
			),
			"SORT" => 50
		);

		if ($USER->CanDoOperation("edit_php"))
		{
			$arMenu[] = Array(
				"TEXT"=>GetMessage("top_panel_edit_page_php"),
				"TITLE"=>GetMessage("top_panel_edit_page_php_title"),
				"ICON"=>"panel-edit-php",
				"ACTION"=>$APPLICATION->GetPopupLink(Array(
					"URL" => "/webmin/admin/public_file_edit_src.php?lang=".LANGUAGE_ID."&path=".$encCurrentFilePath."&site=".SITE_ID."&back_url=".$encRequestUri,
					"PARAMS" => Array("width"=>770, "height" => 570, "resize" => true))
				),
				"SORT" => 60
			);
		}

		

		$arMenu[] = Array(
			"TEXT"=>GetMessage("top_panel_page_prop"),
			"TITLE"=>GetMessage("top_panel_page_prop_title"),
			"ICON"=>"panel-file-props",
			"ACTION"=> $APPLICATION->GetPopupLink(Array(
				"URL"=>"/webmin/admin/public_file_property.php?lang=".LANGUAGE_ID."&site=".SITE_ID."&path=".$encCurrentFilePath."&back_url=".$encRequestUri,
				"PARAMS" => Array("min_width"=>450, "min_height" => 250))
			),
			"SORT" => 20
		);
	}
	
	if (IsCanEditPermission($currentFilePath, $documentRoot, $filemanExists))
	{
		//access button
		$arMenu[] = Array(
			"TEXT"=>GetMessage("top_panel_access_page_new"),//GetMessage("top_panel_access_page"),
			"TITLE"=>GetMessage("top_panel_access_page_title"),
			"ICON"=>"panel-file-access",
			"ACTION"=>$APPLICATION->GetPopupLink(Array(
				"URL"=>"/webmin/admin/public_access_edit.php?lang=".LANGUAGE_ID."&site=".SITE_ID."&path=".$encCurrentFilePath."&back_url=".$encRequestUri,
				"PARAMS" => Array("min_width"=>450, "min_height" => 250)
			)),
			"SORT" => 70
		);
	}
	
	
	//delete button
	if (IsCanDeletePage($currentFilePath, $documentRoot, $filemanExists))
	{
		$arMenu[] = array(
			"TEXT" => GetMessage("top_panel_del_page"),
			"ID" => "delete",
			"ICON"=>"icon-delete",
			"ALT"=>GetMessage("top_panel_del_page"),
			"TEXT"=> GetMessage("top_panel_del_page"),//GetMessage("top_panel_del"),
			"ACTION" => $APPLICATION->GetPopupLink(array(
				"URL" => "/webmin/admin/public_file_delete.php?lang=".LANGUAGE_ID."&site=".SITE_ID."&path=".$encCurrentFilePath,
				"PARAMS" => Array(
					"min_width"=>250, 
					"min_height" => 180, 
					'height' => 180, 
					'width' => 350
				)
			)),
			"SORT" => 80
		);
	}
	
	if (!empty($arMenu))
	{
		//check anonymous access
		$arOperations = CUser::GetFileOperations(array(SITE_ID, $currentFilePath), array(2));
		$bAllowAnonymous = in_array("fm_view_file", $arOperations);

		$APPLICATION->AddPanelButton(array(
			"HREF"=>($defaultUrl == "" ? "" : "javascript:".$defaultUrl),
			"TYPE" => "BIG",
			"ID"=>"edit",
			"ICON"=>($bAllowAnonymous? "bx-panel-edit-page-icon":"bx-panel-edit-secret-page-icon"),
			"ALT"=>GetMessage("top_panel_edit_title"),
			"TEXT"=>GetMessage("top_panel_edit_new"),//GetMessage("top_panel_edit"),
			"MAIN_SORT"=>"200",
			"SORT"=>10,
			"MENU"=> $arMenu,
			"RESORT_MENU" => true
		));
	}
	
	// EDIT SECTION button
	$arMenu = array();
	if (IsCanEditSection($currentDirPath, $filemanExists))
	{
		$defaultUrl = 'javascript:'.$APPLICATION->GetPopupLink(array(
				"URL"=>"/webmin/admin/public_folder_edit.php?lang=".LANGUAGE_ID."&site=".SITE_ID."&path=".urlencode($APPLICATION->GetCurDir())."&back_url=".$encRequestUri,
                "PARAMS" => Array("min_width"=>450, "min_height" => 250)
            )

		);
			
		$arMenu[] = Array(
			"TEXT"=>GetMessage("top_panel_folder_prop"),
			"TITLE"=>GetMessage("top_panel_folder_prop_title"),
			"ICON"=>"panel-folder-props",
			"DEFAULT" => true,
			"ACTION"=> $defaultUrl,
			"SORT"=>10,
		);
		
		$arMenu[] = Array("SEPARATOR"=>true, "SORT"=>15);
	}
	
	
	if (IsCanEditPermission($currentDirPath, $documentRoot, $filemanExists))
	{
		$arMenu[] = Array(
			"TEXT"=>GetMessage("top_panel_access_folder_new"), //GetMessage("top_panel_access_folder"),
			"TITLE"=>GetMessage("top_panel_access_folder_title"),
			"ICON"=>"panel-folder-access",
			"ACTION"=>$APPLICATION->GetPopupLink(Array(
				"URL"=>"/webmin/admin/public_access_edit.php?lang=".LANGUAGE_ID."&site=".SITE_ID."&path=".$encCurrentDirPath."&back_url=".$encRequestUri,
				"PARAMS" => Array("min_width"=>450, "min_height" => 250))
			),
			"SORT"=>30,
		);
	}
	
	if (!empty($arMenu))
	{
		//check anonymous access
		$arOperations = CUser::GetFileOperations(array(SITE_ID, $currentDirPath), array(2));
		$bAllowAnonymous = in_array("fm_view_listing", $arOperations);

		$APPLICATION->AddPanelButton(array(
			"HREF"=> $defaultUrl,
			"ID" => 'edit_section',
			"TYPE" => "BIG",
			"TEXT"=>GetMessage("top_panel_folder_prop_new"),//GetMessage("top_panel_folder_prop"),
			"TITLE"=>GetMessage("top_panel_folder_prop_title"),
			"ICON"=>($bAllowAnonymous? "bx-panel-edit-section-icon":"bx-panel-edit-secret-section-icon"),
			"MAIN_SORT" => "200",
			"SORT" => 20,
			"MENU" => $arMenu,
			"RESORT_MENU" => true
		));
	}
	
// STRUCTURE button and submenu
	if($USER->CanDoOperation('fileman_view_file_structure') && $USER->CanDoFileOperation('fm_edit_existent_folder', array(SITE_ID, "/")))
	{
		$defaultUrl = $APPLICATION->GetPopupLink(array(
			"URL" => "/webmin/admin/public_structure.php?lang=".LANGUAGE_ID."&site=".SITE_ID."&path=".$encCurrentFilePath."&templateID=".$encSiteTemplateId,
			"PARAMS" => Array("width"=>350, "height"=>600, "resize" => true)));
		$arMenu = Array();
		if(/*$showMode <> 'view' && */$filemanExists)
		{
			$arMenu[] = array(
				"TEXT" => GetMessage("main_top_panel_struct"),
				"TITLE"=> GetMessage("main_top_panel_struct_title"),
				"ACTION" => $defaultUrl,
				"DEFAULT" => true,
			);
			$arMenu[] = array('SEPARATOR'=>true);
			$arMenu[] = array(
				"TEXT" => GetMessage("main_top_panel_struct_panel"),
				"TITLE"=> GetMessage("main_top_panel_struct_panel_title"),
				"ACTION"	=> "jsUtils.Redirect([], '".CUtil::JSEscape("/webmin/admin/fileman_admin.php?lang=".LANGUAGE_ID."&site=".SITE_ID."&path=".urlencode($APPLICATION->GetCurDir()))."')",
			);
		}
		
		$APPLICATION->AddPanelButton(Array(
			"HREF"=>"javascript:".$defaultUrl,
			"ID"=>"structure",
			"ICON"=>"bx-panel-site-structure-icon",
			"ALT"=>GetMessage("main_top_panel_struct_title"),
			"TEXT"=>GetMessage("main_top_panel_structure"),
			"MAIN_SORT"=>"300",
			"SORT"=>30,
			"MENU"=> $arMenu,
		));
	}
	
	
	//cache button
	if ($USER->CanDoOperation("cache_control"))
	{
		//recreate cache on the current page
		$arMenu = Array(
			array(
				"TEXT"=>GetMessage("top_panel_cache_page"),
				"TITLE"=>GetMessage("top_panel_cache_page_title"),
				"ICON"=>"panel-page-cache",
				"ACTION" => "BX.clearCache()",
				"DEFAULT"=>true,
			),
		);
		if (!empty($APPLICATION->aCachedComponents))
		{
			$arMenu[] = array(
				"TEXT"=>GetMessage("top_panel_cache_comp"),
				"TITLE"=>GetMessage("top_panel_cache_comp_title"),
				"ICON"=>"panel-comp-cache",
				"ACTION"=>"jsComponentUtils.ClearCache('component_name=".CUtil::addslashes(implode(",", $APPLICATION->aCachedComponents))."&site_id=".SITE_ID."');",
			);
		}
		$arMenu[] = array("SEPARATOR"=>true);
		$arMenu[] = array(
			"TEXT"=>GetMessage("top_panel_cache_not"),
			"TITLE"=>GetMessage("top_panel_cache_not_title"),
			"ICON"=>($_SESSION["SESS_CLEAR_CACHE"] == "Y"? "checked":""),
			"ACTION"=>"jsUtils.Redirect([], '".CUtil::addslashes($APPLICATION->GetCurPageParam("clear_cache_session=".($_SESSION["SESS_CLEAR_CACHE"] == "Y"? "N" : "Y"), array("clear_cache_session")))."');",
		);

		$APPLICATION->AddPanelButton(array(
			"HREF" => "javascript:BX.clearCache()",
			"TYPE" => "BIG",
			"ICON"=>"bx-panel-clear-cache-icon",
			"TEXT"=> GetMessage("top_panel_cache_new"),//GetMessage("top_panel_cache"),
			"ALT"=>GetMessage("top_panel_clear_cache"),
			"MAIN_SORT"=>"400",
			"SORT"=>10,
			"MENU"=>$arMenu,
		));
	}

	if ($USER->CanDoOperation('edit_php') || !empty($APPLICATION->arPanelFutureButtons['components']))
	{
		if (empty($APPLICATION->arPanelFutureButtons['components']))
		{
			$APPLICATION->AddPanelButtonMenu('components', 
				array(
					"TEXT"=>GetMessage("top_panel_edit_mode"),
					"TITLE"=>GetMessage("top_panel_edit_mode_title"),
					"ACTION"=>"jsUtils.Redirect([], BX('bx-panel-toggle').href);"
				)
			);
		}
		
		$APPLICATION->AddPanelButton(array(
			"ID"=>"components",
			"ICON"=>"bx-panel-components-icon",
			"ALT"=>GetMessage("main_comp_button_title"),
			"TEXT"=>GetMessage("top_panel_comp"),//GetMessage("main_comp_button"),
			"MAIN_SORT"=>"500",
			"SORT"=>10,
		));
	}

	//TEMPLATE button and submenu
	if ($USER->CanDoOperation("edit_php") || $USER->CanDoOperation("view_other_settings") || $USER->CanDoOperation("lpa_template_edit"))
	{
		$arMenu = array();
		$bUseSubmenu = false;

		$defaultUrl = '';

		if ($USER->CanDoOperation("edit_php"))
		{
			$filePath = BX_ROOT."/templates/".SITE_TEMPLATE_ID."/styles.css";
	
			if (file_exists($_SERVER['DOCUMENT_ROOT'].$filePath))
			{
				$arMenu[] = array(
					"TEXT"	=> GetMessage("top_panel_templ_site_css"),
					"TITLE"	=> GetMessage("top_panel_templ_site_css_title"),
					"ICON"	=> "panel-edit-text",
					"ACTION"=> $APPLICATION->GetPopupLink(
						array(
							"URL" => "/webmin/admin/public_file_edit_src.php?lang=".LANGUAGE_ID."&path=".urlencode($filePath)."&site=".SITE_ID."&back_url=".$encRequestUri,
							"PARAMS" => array(
								"width" => 770,
								'height' => 570,
								'resize' => true,
							)
						)
					),
				);
				$bUseSubmenu = true;
			}
	
			$filePath = BX_ROOT."/templates/".SITE_TEMPLATE_ID."/template_styles.css";
	
			if (file_exists($_SERVER['DOCUMENT_ROOT'].$filePath))
			{
				$arMenu[] = array(
						"TEXT"   => GetMessage("top_panel_templ_templ_css"),
						"TITLE"  => GetMessage("top_panel_templ_templ_css_title"),
						"ICON"   => "panel-edit-text",
						"ACTION" => $APPLICATION->GetPopupLink(
							array(
								"URL" => "/webmin/admin/public_file_edit_src.php?lang=".LANGUAGE_ID."&path=".urlencode($filePath)."&site=".SITE_ID."&back_url=".$encRequestUri,
								"PARAMS" => array(
									"width" => 770,
									'height' => 570,
									'resize' => true,
								)
							)
						),
					);
				$bUseSubmenu = true;
			}
		}

		$arSubMenu = array(
			array(
				"TEXT"		=>GetMessage("top_panel_templ_edit"),
				"TITLE"		=>GetMessage("top_panel_templ_edit_title"),
				"ICON"		=>"icon-edit",
				"ACTION"	=> "jsUtils.Redirect([], '/webmin/admin/template_edit.php?lang=".LANGUAGE_ID."&ID=".$encSiteTemplateId."')",
				"DEFAULT"	=>!$bUseSubmenu,
			),

			array(
				"TEXT"		=> GetMessage("top_panel_templ_site"),
				"TITLE"		=> GetMessage("top_panel_templ_site_title"),
				"ICON"		=> "icon-edit",
				"ACTION"	=> "jsUtils.Redirect([], '/webmin/admin/site_edit.php?lang=".LANGUAGE_ID."&LID=".SITE_ID."')",
				"DEFAULT"	=> false,
			),
		);

		if ($bUseSubmenu)
		{
			$arMenu[] = array('SEPARATOR' => "Y");

			$arMenu[] = array(
				"TEXT" => GetMessage("top_panel_cp"),
				"MENU" => $arSubMenu,
			);
		}
		else
		{
			$arMenu = $arSubMenu;
			$defaultUrl = $arSubMenu[0]['ACTION'];
		}

		$APPLICATION->AddPanelButton(Array(
			"HREF" => $defaultUrl,
			"ICON" => "bx-panel-site-template-icon",
			"ALT" => GetMessage("top_panel_templ_title"),
			"TEXT" => GetMessage("top_panel_templ"),
			"MAIN_SORT" => "500",
			"SORT" => 30,
			"MENU" => $arMenu
		));
	}



	//statistics buttons
	if ($USER->CanDoOperation("edit_php"))
	{
		//show debug information
		$cmd = ($_SESSION["SESS_SHOW_INCLUDE_TIME_EXEC"]=="Y" && $_SESSION["SESS_SHOW_TIME_EXEC"]=="Y" && $DB->ShowSqlStat? "N" : "Y");
		$url = $APPLICATION->GetCurPageParam("show_page_exec_time=".$cmd."&show_include_exec_time=".$cmd."&show_sql_stat=".$cmd, array("show_page_exec_time", "show_include_exec_time", "show_sql_stat"));
		$arMenu = array(
			array(
				"TEXT"=>GetMessage("top_panel_debug_summ"),
				"TITLE"=>GetMessage("top_panel_debug_summ_title"),
				"ICON"=>($cmd == "N"? "checked":""),
				"ACTION"=>"jsUtils.Redirect([], '".CUtil::addslashes($url)."');",
				"DEFAULT"=>true,
			),
			array("SEPARATOR"=>true),
			array(
				"TEXT"=>GetMessage("top_panel_debug_sql"),
				"TITLE"=>GetMessage("top_panel_debug_sql_title"),
				"ICON"=>($DB->ShowSqlStat? "checked":""),
				"ACTION"=>"jsUtils.Redirect([], '".CUtil::addslashes($APPLICATION->GetCurPageParam("show_sql_stat=".($DB->ShowSqlStat? "N" : "Y"), array("show_sql_stat")))."');",
			),
			array(
				"TEXT"=>GetMessage("top_panel_debug_incl"),
				"TITLE"=>GetMessage("top_panel_debug_incl_title"),
				"ICON"=>($_SESSION["SESS_SHOW_INCLUDE_TIME_EXEC"]=="Y"? "checked":""),
				"ACTION"=>"jsUtils.Redirect([], '".CUtil::addslashes($APPLICATION->GetCurPageParam("show_include_exec_time=".($_SESSION["SESS_SHOW_INCLUDE_TIME_EXEC"]=="Y"? "N" : "Y"), array("show_include_exec_time")))."');",
			),
			array(
				"TEXT"=>GetMessage("top_panel_debug_time"),
				"TITLE"=>GetMessage("top_panel_debug_time_title"),
				"ICON"=>($_SESSION["SESS_SHOW_TIME_EXEC"]=="Y"? "checked":""),
				"ACTION"=>"jsUtils.Redirect([], '".CUtil::addslashes($APPLICATION->GetCurPageParam("show_page_exec_time=".($_SESSION["SESS_SHOW_TIME_EXEC"]=="Y"? "N" : "Y"), array("show_page_exec_time")))."');",
			),
		);
		if(IsModuleInstalled("compression"))
		{
			$bShowCompressed = ($_SESSION["SESS_COMPRESS"] == "Y" && strtoupper($_GET["compress"])<>"N" || strtoupper($_GET["compress"])=="Y");
			$arMenu[] = array("SEPARATOR"=>true);
			$arMenu[] = array(
				"TEXT"=>GetMessage("top_panel_debug_compr"),
				"TITLE"=>GetMessage("top_panel_debug_compr_title"),
				"ICON"=>($bShowCompressed? "checked":""),
				"ACTION"=>"jsUtils.Redirect([], '".CUtil::addslashes($APPLICATION->GetCurPageParam("compress=".($bShowCompressed? "N" : "Y"), array("compress")))."');",
			);
		}

		$APPLICATION->AddPanelButton(array(
			"HREF"=>$url,
			"ICON"=>"bx-panel-performance-icon",
			"TEXT"=>GetMessage("top_panel_debug"),
			"ALT"=>GetMessage("top_panel_show_debug"),
			"MAIN_SORT"=>"500",
			"SORT"=>40,
			"MENU"=>$arMenu,
		));
	}

}

function GetPanelHtml()
{
	global $USER, $APPLICATION, $DB;

	if ($APPLICATION->ShowPanel === false || (!$USER->IsAuthorized() && $APPLICATION->ShowPanel !== true))
		return "";
	
	$APPLICATION->InitPanelIcons();

	$arPanelButtons = &$APPLICATION->arPanelButtons;
	usort($arPanelButtons, "Panel_Sort");

	/* Now we can display buttons */
	$bShowPanel = false;
	foreach($arPanelButtons as $key=>$arValue)
	{
		if(trim($arValue["HREF"]) <> "" || is_array($arValue["MENU"]) && !empty($arValue["MENU"]))
		{
			$bShowPanel = true;
			break;
		}
	}

	if ($bShowPanel === false && $APPLICATION->ShowPanel !== true)
		return "";

	require_once($_SERVER["DOCUMENT_ROOT"].BX_ROOT."/modules/main/interface/init_admin.php");

	$APPLICATION->PanelShowed = true;

	if ($_GET["back_url_admin"] <> "")
		$_SESSION["BACK_URL_ADMIN"] = $_GET["back_url_admin"];
	
	$aUserOpt = CUserOptions::GetOption("admin_panel", "settings");
	$aUserOptGlobal = CUserOptions::GetOption("global", "settings");

	$toggleModeSet = false;
	if (isset($_GET["bitrix_include_areas"]) && $_GET["bitrix_include_areas"] <> "")
	{
		$APPLICATION->SetShowIncludeAreas($_GET["bitrix_include_areas"]=="Y");
		$toggleModeSet = true;
	}
	/*
	if (isset($_GET["bitrix_show_mode"]) && $_GET["bitrix_show_mode"] <> "")
		$APPLICATION->SetPublicShowMode($_GET["bitrix_show_mode"]);
	*/

	$showMode = $APPLICATION->GetPublicShowMode();

	$params = DeleteParam(array("bitrix_include_areas", "bitrix_show_mode", "back_url_admin"));
	$href = $APPLICATION->GetCurPage();
	$hrefParams = ($params<>""? "&amp;".htmlspecialchars($params):"");

	$toggleModeDynamic = $aUserOptGlobal['panel_dynamic_mode'] == 'Y';
	$toggleMode = $toggleModeDynamic && !$toggleModeSet
		? $aUserOpt['edit'] == 'on' 
		: $APPLICATION->GetShowIncludeAreas() == 'Y';
	$aUserOpt['edit'] = $toggleMode ? 'on' : 'off';
	CUserOptions::SetOption('admin_panel', 'settings', $aUserOpt);
	
	$toggleModeLink = $href.'?bitrix_include_areas='.($toggleMode ? 'N' : 'Y').$hrefParams;

	$maxQuota = COption::GetOptionInt("main", "disk_space", 0)*1024*1024;
	if($maxQuota > 0)
	{
		$quota = new CDiskQuota();
		$free = $quota->GetDiskQuota();
	}
	
	//updates button
	$bUpdate = false;
	if($USER->CanDoOperation('install_updates'))
	{
		$update_res = UpdateTools::GetUpdateResult();

		if($update_res["result"] == true || $update_res['error'] <> '')
		{
			$bUpdate = true;
			/*$APPLICATION->AddPanelButton(Array(
				"HREF"=> "/bitrix/admin/sysupdate.php?lang=".LANGUAGE_ID,
				"ICON"=>"icon-update",
				"ALT"=>($update_res["result"] == true? GetMessage("top_panel_updates_hint") : GetMessage("top_panel_update_hint2")),
				"TEXT"=>GetMessage("top_panel_update_btn"),
				"MAIN_SORT"=>"50",
				"SORT"=>10,
				"TOOLTIP"=>$update_res['tooltip'],
				"TOOLTIP_ACTION"=>"jsUserOptions.SaveOption('update', 'options', 'tooltip', 'off');",
			));*/
		}
	}

	$result = $APPLICATION->__ShowPanelScripts(true);
	$result .= '
<!--[if lte IE 6]>
<style type="text/css">#bx-panel {display:none !important;}</style>
<div id="bx-panel-error">'.GetMessage("top_panel_browser").'</div><![endif]-->
<script type="text/javascript">BX.admin.dynamic_mode='.($toggleModeDynamic ? 'true' : 'false').'; BX.admin.dynamic_mode_show_borders = '.($toggleMode ? 'true' : 'false').';</script>
<div style="display:none; overflow:hidden;" id="bx-panel-back"></div>
<div id="bx-panel"'.($aUserOpt["collapsed"] == "on" ? ' class="bx-panel-folded"':'').'>
	<div id="bx-panel-top">
		<div id="bx-panel-tabs">
';
	$result .= '
			<a id="bx-panel-menu" href="javascript:void(0)" onclick="jsStartMenu.ShowStartMenu(this, \''.CUtil::JSEscape($href.($params<>""? "?".htmlspecialchars($params):"")).'\');"><span>'.GetMessage("top_panel_menu").'</span></a><a id="bx-panel-view-tab"><span>'.GetMessage("top_panel_site").'</span></a><a id="bx-panel-admin-tab" href="'.(
					$_SESSION["BACK_URL_ADMIN"] <> ""
					? htmlspecialchars($_SESSION["BACK_URL_ADMIN"]).(strpos($_SESSION["BACK_URL_ADMIN"], "?") !== false? "&amp;":"?") 
					: '/webmin/admin/index.php?lang='.LANGUAGE_ID.'&amp;'
				).'back_url_pub='.urlencode($href.($params<>""? "?".$params:"")).'"><span>'.GetMessage("top_panel_admin").'</span></a>';
				
	if ($bUpdate)
	{
		$result .= '<span id="bx-panel-updates-icon"></span><a id="bx-panel-updates" href="/webmin/admin/sysupdate.php?lang='.LANGUAGE_ID.'">'.GetMessage("top_panel_update_btn").'</a>';
	}
	
	$result .= '
		</div>
		<div id="bx-panel-userinfo">
';
		
	if ($maxQuota > 0)
	{
		$free = round($free/$maxQuota*100);
		
		$result .= '<span id="bx-panel-quota"><span id="bx-panel-quota-caption">'.GetMessage("top_panel_free").' '.$free.'%</span><span id="bx-panel-quota-indicator"><span id="bx-panel-quota-slider" style="width:'.(100 - $free).'%;'.($free <= 10 ? ' background-color: #F55 !important;' : '').'"></span></span></span><span class="bx-panel-userinfo-separator bx-panel-expand-mode-only"></span>';
	}

	$bCanProfile = $USER->CanDoOperation('view_own_profile') || $USER->CanDoOperation('edit_own_profile');
	if ($bCanProfile)
	{
		$result .= '<a href="/webmin/admin/user_edit.php?lang='.LANGUAGE_ID.'&ID='.$USER->GetID().'" id="bx-panel-user">'.htmlspecialchars($USER->GetFullName()).' ('.htmlspecialchars($USER->GetLogin()).')</a><span class="bx-panel-userinfo-separator"></span>';
	}
	else
	{
		$result .= '<a id="bx-panel-user">'.htmlspecialchars($USER->GetFullName()).' ('.htmlspecialchars($USER->GetLogin()).')</a><span class="bx-panel-userinfo-separator"></span>';
	}
	
	$result .= '<a href="'.$APPLICATION->GetCurPage().'?logout=yes'.htmlspecialchars(($s=DeleteParam(array("logout"))) == ""? "":"&".$s).'" id="bx-panel-logout">'.GetMessage("top_panel_logout").'</a><span class="bx-panel-userinfo-separator bx-panel-folded-mode-only"></span>';
	
	$result .= '<a href="'.$toggleModeLink.'" id="bx-panel-small-toggle" class="bx-panel-toggle'.($toggleMode ? '-on' : '-off').'"><span id="bx-panel-small-toggle-caption">'.GetMessage("top_panel_edit_mode_new").'</span><span id="bx-panel-small-toggle-icon"></span></a><span class="bx-panel-userinfo-separator bx-panel-folded-mode-only"></span>';
	
	$result .= '<a href="javascript:void(0)" id="bx-panel-expander"><span id="bx-panel-expander-text">'.GetMessage("top_panel_expand").'</span><span id="bx-panel-expander-arrow"></span></a><span class="bx-panel-userinfo-separator"></span>';
	
	$result .= '<a href="javascript:void(0)" id="bx-panel-pin"'.($aUserOpt['fix'] == 'on' ? ' class="bx-panel-pin-fixed"' : '').'></a>';
	
	$result .= '
		</div>
	</div>
';

/* BUTTONS */
	$result .= '<div id="bx-panel-site-toolbar"><div id="bx-panel-switcher">';
	
	$result .= '<a href="'.$toggleModeLink.'" id="bx-panel-toggle" class="bx-panel-toggle'.($toggleMode ? '-on' : '-off').'"><span id="bx-panel-toggle-icon"></span><span class="bx-panel-break"></span><span id="bx-panel-toggle-caption">'.GetMessage("top_panel_edit_mode_new").'</span><span class="bx-panel-break"></span><span id="bx-panel-toggle-caption-mode">'.($toggleMode ? GetMessage("top_panel_on") : GetMessage("top_panel_off")).'</span></a>';
	$result .= '<a href="javascript:void(0)" id="bx-panel-hider">'.GetMessage("top_panel_collapse").'<span id="bx-panel-hider-arrow"></span></a>';
    
	$result .= '</div><div id="bx-panel-buttons"><div id="bx-panel-buttons-inner">';

	$main_sort = "";
	$last_btn_type = '';
	$last_btn_small_cnt = 0;
	
	$result .= '<span class="bx-panel-button-group">';
	foreach($arPanelButtons as $key=>$arButton)
	{
		if($main_sort != $arButton["MAIN_SORT"] && $main_sort<>"")
		{
			$result .= '</span><span class="bx-panel-button-separator"></span><span class="bx-panel-button-group">';
			$last_btn_small_cnt = 0;
		}

		
		$arButton['TYPE'] = $arButton['TYPE'] == 'BIG' ? 'BIG' : 'SMALL';
		
		//very old behaviour
		if(is_set($arButton, "SRC_0"))
			$arButton["SRC"] = $arButton["SRC_0"];

		$arButton['HREF'] = trim($arButton['HREF']);
		$bHasAction = $arButton['HREF'] != '';

		if (array_key_exists("RESORT_MENU", $arButton) && $arButton["RESORT_MENU"] === true && is_array($arButton['MENU']) && !empty($arButton['MENU']))
			usort($arButton['MENU'], "__PanelMenuSort");
		
		$bHasMenu = is_array($arButton['MENU']) && count($arButton['MENU']) > 0;
		
		if ($bHasMenu && !$bHasAction)
		{
			foreach ($arButton['MENU'] as $arItem)
			{
				if ($arItem['DEFAULT'])
				{
					$arButton['HREF'] = $arItem['HREF'];
					$bHasAction = true;
				}
			}
		}
		
		if ($last_btn_type != '' && $arButton['TYPE'] != $last_btn_type && $main_sort == $arButton["MAIN_SORT"])
		{
			$result .= '</span><span class="bx-panel-button-group">';
			$last_btn_small_cnt = 0;
		}
		
		if ($bHasAction && substr(strtolower($arButton['HREF']), 0, 11) == 'javascript:')
		{
			$arButton['ONCLICK'] = substr($arButton['HREF'], 11);
			$arButton['HREF'] = 'javascript:void(0)';
		}
		
		switch ($arButton['TYPE'])
		{
			case 'SMALL':
				if ($last_btn_small_cnt >= 3 && $main_sort == $arButton["MAIN_SORT"])
				{
					$result .= '</span><span class="bx-panel-button-group">';
					$last_btn_small_cnt = 0;
				}
				elseif ($last_btn_small_cnt > 0)
				{
					$result .= '<span class="bx-panel-break"></span>';
				}
				
				$result .= '<span class="bx-panel-small-button"><span class="bx-panel-small-button-inner">';
				
				$button_icon = '<span class="bx-panel-small-button-icon'.($arButton['ICON'] ? ' '.$arButton['ICON'] : '').'"'.($arButton['SRC'] ? ' style="background: scroll transparent url('.htmlspecialchars($arButton['SRC']).') no-repeat center center !important;"' : '').'></span>';
				$button_text = '<span class="bx-panel-small-button-text">'.htmlspecialchars($arButton['TEXT']).'</span>';
				
				if ($bHasAction)
				{
					$result .= '<a href="'.htmlspecialchars($arButton['HREF']).'" onclick="'.htmlspecialchars($arButton['ONCLICK']).'" id="bx_topmenu_btn_'.$key.'">'.$button_icon.$button_text.'</a>';
					$result .= '<script type="text/javascript">BX.admin.panel.RegisterButton({ID: \'bx_topmenu_btn_'.$key.'\', TYPE: \'SMALL\', HOVER_CSS: \'bx-panel-small-button'.($bHasMenu ? '-text' : '').'-hover\'})</script>';
					if ($bHasMenu)
					{
						$result .= '<a href="javascript:void(0)" class="bx-panel-small-button-arrow" id="bx_topmenu_btn_'.$key.'_menu"><span class="bx-panel-small-button-arrow"></span></a>';
						$result .= '<script type="text/javascript">BX.admin.panel.RegisterButton({ID: \'bx_topmenu_btn_'.$key.'_menu\', TYPE: \'SMALL\', MENU: '.CUtil::PhpToJsObject($arButton['MENU']).', HOVER_CSS: \'bx-panel-small-button-arrow-hover\'})</script>';
					}
				}
				elseif ($bHasMenu)
				{
					$result .= '<a href="javascript:void(0)" id="bx_topmenu_btn_'.$key.'">'.$button_icon.$button_text.'<span class="bx-panel-small-single-button-arrow"></span></a>';
					$result .= '<script type="text/javascript">BX.admin.panel.RegisterButton({ID: \'bx_topmenu_btn_'.$key.'\', TYPE: \'SMALL\', MENU: '.CUtil::PhpToJsObject($arButton['MENU']).', HOVER_CSS: \'bx-panel-small-button-hover\'})</script>';
				}
				
				$result .= '</span></span>';
			
				$last_btn_small_cnt++;
			
			break;
			
			case 'BIG':
				$last_btn_small_cnt = 0;
		
				$result .= '<span class="bx-panel-button"><span class="bx-panel-button-inner">';
		
				$button_icon = '<span class="bx-panel-button-icon'.($arButton['ICON'] ? ' '.$arButton['ICON'] : '').'"'.($arButton['SRC'] ? ' style="background: scroll transparent url('.htmlspecialchars($arButton['SRC']).') no-repeat center center !important;"' : '').'></span>';
				
				
				if ($bHasAction && $bHasMenu)
				{
					$button_text = '<span class="bx-panel-button-text">'.str_replace('#BR#', '<span class="bx-panel-break"></span>', $arButton['TEXT']).'&nbsp;<span class="bx-panel-button-arrow"></span></span>';
					$result .= '<a href="'.htmlspecialchars($arButton['HREF']).'" onclick="'.htmlspecialchars($arButton['ONCLICK']).'" id="bx_topmenu_btn_'.$key.'">'.$button_icon.'</a><a id="bx_topmenu_btn_'.$key.'_menu" href="javascript:void(0)">'.$button_text.'</a>';
					$result .= '<script type="text/javascript">
BX.admin.panel.RegisterButton({ID: \'bx_topmenu_btn_'.$key.'\', TYPE: \'BIG\', HOVER_CSS: \'bx-panel-button-icon-hover\'}); BX.admin.panel.RegisterButton({ID: \'bx_topmenu_btn_'.$key.'_menu\', TYPE: \'BIG\', MENU: '.CUtil::PhpToJsObject($arButton['MENU']).', HOVER_CSS: \'bx-panel-button-text-hover\'})
</script>';
				}
				else if ($bHasAction)
				{
					$button_text = '<span class="bx-panel-button-text">'.str_replace('#BR#', '<span class="bx-panel-break"></span>', $arButton['TEXT']).'</span>';
					
					$result .= '<a href="'.htmlspecialchars($arButton['HREF']).'" onclick="'.htmlspecialchars($arButton['ONCLICK']).'" id="bx_topmenu_btn_'.$key.'">'.$button_icon.$button_text.'</a>';
					
					$result .= '<script type="text/javascript">BX.admin.panel.RegisterButton({ID: \'bx_topmenu_btn_'.$key.'\', TYPE: \'BIG\', HOVER_CSS: \'bx-panel-button-hover\'});</script>';

				}
				else // if $bHasMenu
				{
					$button_text = '<span class="bx-panel-button-text">'.str_replace('#BR#', '<span class="bx-panel-break"></span>', $arButton['TEXT']).'&nbsp;<span class="bx-panel-button-arrow"></span></span>';
					
					$result .= '<a href="javascript:void(0)" id="bx_topmenu_btn_'.$key.'_menu">'.$button_icon.$button_text.'</a>';
					
					$result .= '<script type="text/javascript">BX.admin.panel.RegisterButton({ID: \'bx_topmenu_btn_'.$key.'_menu\', TYPE: \'BIG\', MENU: '.CUtil::PhpToJsObject($arButton['MENU']).', HOVER_CSS: \'bx-panel-button-hover\'});</script>';
				}
		
				$result .= '</span></span>';
			break;
		}
		
		$main_sort = $arButton["MAIN_SORT"];
		$last_btn_type = $arButton['TYPE'];
	}
	$result .= '</span>';

	$result .= '</div>
		</div>
	</div>';

	$result .= '
</div>
';

	$result .= '<script type="text/javascript">
	BX.admin.panel.state = {
		fixed: '.($aUserOpt["fix"] == "on" ? 'true' : 'false').',
		collapsed: '.($aUserOpt["collapsed"] == "on" ? 'true' : 'false').'
	}
	</script>';
	
	//start menu preload
	if($aUserOptGlobal["start_menu_preload"] == 'Y')
		$result .= '<script type="text/javascript">BX.ready(function(){jsStartMenu.PreloadMenu(\''.CUtil::JSEscape($href.($params<>""? "?".$params:"")).'\');});</script>';
	
	//show script to play sound
	$result .= $GLOBALS["adminPage"]->ShowSound();
	
	return $result;
}
?>