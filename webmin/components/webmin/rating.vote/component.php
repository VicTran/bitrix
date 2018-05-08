<?if(!defined("B_PROLOG_INCLUDED") || B_PROLOG_INCLUDED!==true)die();

	$arParams['TOTAL_VALUE']		  = IntVal($arParams['TOTAL_VALUE']);
	$arParams['TOTAL_VOTES'] 		  = IntVal($arParams['TOTAL_VOTES']);
	$arParams['TOTAL_POSITIVE_VOTES'] = IntVal($arParams['TOTAL_POSITIVE_VOTES']);
	$arParams['TOTAL_NEGATIVE_VOTES'] = IntVal($arParams['TOTAL_NEGATIVE_VOTES']);

	if (IntVal($arParams['OWNER_ID']) == $GLOBALS["USER"]->GetId() || !$GLOBALS["USER"]->IsAuthorized())
		$arParams['USER_HAS_VOTED'] = 'Y';
	else 
		$arParams['USER_HAS_VOTED']	= in_array($arParams['USER_HAS_VOTED'], array('Y', 'N')) ? $arParams['USER_HAS_VOTED'] : 'N';
	
	CUtil::InitJSCore(array('ajax'));
		
	$this->IncludeComponentTemplate();
?>