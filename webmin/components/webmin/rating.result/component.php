<?if(!defined("B_PROLOG_INCLUDED") || B_PROLOG_INCLUDED!==true)die();

	$arParams['RATING_ID'] 		= IntVal($arParams['RATING_ID']);
	$arParams['ENTITY_ID'] 		= IntVal($arParams['ENTITY_ID']);
	$arParams['CURRENT_VALUE']  = ceil($arParams['CURRENT_VALUE']);
	$arParams['PREVIOUS_VALUE'] = ceil($arParams['PREVIOUS_VALUE']);

	$this->IncludeComponentTemplate();
?>