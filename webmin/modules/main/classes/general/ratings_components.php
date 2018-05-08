<?
IncludeModuleLangFile($_SERVER["DOCUMENT_ROOT"].BX_ROOT."/modules/main/classes/general/ratings_components.php");

class CAllRatingsComponentsMain
{	
	// return configs of component-rating
	function OnGetRatingConfigs()
	{
	    $arConfigs = array(
	    	'MODULE_ID' => 'MAIN',
	    	'MODULE_NAME' => GetMessage('MAIN_RATING_NAME'),
	    );
		$arConfigs["COMPONENT"]["USER"]["VOTE"][] = array(
			"ID"	=> 'USER',
			"REFRESH_TIME"	=> '3600',
			"CLASS"	=> 'CRatingsComponentsMain',
			"CALC_METHOD"	=> 'CalcUserVoteMainUser',			
			"NAME" 	=> GetMessage('MAIN_RATING_USER_VOTE_USER_NAME'),
		    "FIELDS" => array(
				array(
					"ID" => 'COEFFICIENT',
					"DEFAULT" => '1',
				),
			)
		);
		
		return $arConfigs;
	}
	
	// Calculation functions
	function CalcUserVoteMainUser($arConfigs)
	{
		global $DB;
		
		$strSql = "
			SELECT ENTITY_ID, SUM(TOTAL_VALUE) as TOTAL_VALUE
			FROM b_rating_voting
			WHERE ENTITY_TYPE_ID = 'USER'
			GROUP BY ENTITY_ID
		";
		$res = $DB->Query($strSql, false, $err_mess.__LINE__);
		$arComponentResults = array();
		while($arRes = $res->Fetch())
		{
			$arComponentResults[$arRes['ENTITY_ID']] = array(
				'ENTITY_TYPE_ID' => $arRes['ENTITY_ID'],
				'TOTAL_VALUE'	 => $arRes['TOTAL_VALUE']*$arConfigs['CONFIG']['COEFFICIENT']
			);			
		}
		
		CRatings::AddComponentResults($arConfigs, $arComponentResults);
		
		return true;
	}
	
	// return support object
	function OnGetRatingObject()
	{
		$arRatingConfigs = CRatingsComponentsMain::OnGetRatingConfigs();
		foreach ($arRatingConfigs as $SupportType => $value)
			$arSupportType[] = $SupportType;
			
		return $arSupportType;
	}
	
	// check the value of the component-rating which relate to the module
	function OnAfterAddRating($ID, $arFields)
	{
		$arFields['CONFIGS']['MAIN'] = CRatingsComponentsMain::__CheckFields($arFields['ENTITY_ID'], $arFields['CONFIGS']['MAIN']);
		
		return $arFields;
	}
	
	// check the value of the component-rating which relate to the module
	function OnAfterUpdateRating($ID, $arFields)
	{
		$arFields['CONFIGS']['MAIN'] = CRatingsComponentsMain::__CheckFields($arFields['ENTITY_ID'], $arFields['CONFIGS']['MAIN']);
		
		return $arFields;
	}
	
	// Utilities
	
	// check input values, if value does not validate, set the default value
	function __CheckFields($entityId, $arConfigs)
	{
		$arDefaultConfig = CRatingsComponentsMain::__AssembleConfigDefault($entityId);
		
		if ($entityId == "USER") {
			if (isset($arConfigs['VOTE']['USER']))
				if (!preg_match('/^\d+\.?\d*$/', $arConfigs['VOTE']['USER']['COEFFICIENT']))
					$arConfigs['VOTE']['USER']['COEFFICIENT'] = $arDefaultConfig['VOTE']['USER']['COEFFICIENT']['DEFAULT'];
		}
		
		return $arConfigs;
	}
	
	// collect the default and regular expressions for the fields component-rating
	function __AssembleConfigDefault($objectType = null) 
	{
		$arConfigs = array();
		$arRatingConfigs = CRatingsComponentsMain::OnGetRatingConfigs();
		if (is_null($objectType)) 
		{
			foreach ($arRatingConfigs as $OBJ_TYPE => $TYPE_VALUE)
				foreach ($TYPE_VALUE as $RAT_TYPE => $RAT_VALUE)
					foreach ($RAT_VALUE as $VALUE_CONFIG)
				   		foreach ($VALUE_CONFIG['FIELDS'] as $VALUE_FIELDS) 
				   		   $arConfigs[$OBJ_TYPE][$RAT_TYPE][$VALUE_CONFIG['ID']][$VALUE_FIELDS['ID']]['DEFAULT'] = $VALUE_FIELDS['DEFAULT'];
		}
		else 
		{
			foreach ($arRatingConfigs[$objectType] as $RAT_TYPE => $RAT_VALUE)
				foreach ($RAT_VALUE as $VALUE_CONFIG)
					foreach ($VALUE_CONFIG['FIELDS'] as $VALUE_FIELDS) 
				   		$arConfigs[$RAT_TYPE][$VALUE_CONFIG['ID']][$VALUE_FIELDS['ID']]['DEFAULT'] = $VALUE_FIELDS['DEFAULT'];

		}
		
		return $arConfigs;
	}
}

?>