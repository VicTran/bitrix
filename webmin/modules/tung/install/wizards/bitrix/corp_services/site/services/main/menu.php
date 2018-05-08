<?
if(!defined("B_PROLOG_INCLUDED") || B_PROLOG_INCLUDED!==true)
	die();
//COption::SetOptionInt("fileman", "num_menu_param", 1, false ,WIZARD_SITE_ID);
//if(IntVal(COption::GetOptionInt("fileman", "num_menu_param", 1, WIZARD_SITE_ID)) == 1)
//{
	COption::SetOptionString("fileman", "different_set", "Y");
	CModule::IncludeModule('fileman');
	$arMenuTypes = GetMenuTypes(WIZARD_SITE_ID);
	if($arMenuTypes['left'] && $arMenuTypes['left'] == GetMessage("WIZ_MENU_LEFT_DEFAULT"))
		$arMenuTypes['left'] =  GetMessage("WIZ_MENU_LEFT");
	if(!$arMenuTypes['leftfirst'])
		$arMenuTypes['leftfirst'] = GetMessage("WIZ_MENU_LEFT_FIRST");
		
	print_r($arMenuTypes);
	SetMenuTypes($arMenuTypes, WIZARD_SITE_ID);
	COption::SetOptionInt("fileman", "num_menu_param", 2, false ,WIZARD_SITE_ID);

//}
?>