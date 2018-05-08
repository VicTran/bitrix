<?
require($_SERVER["DOCUMENT_ROOT"].BX_ROOT."/modules/main/classes/general/ratings.php");
IncludeModuleLangFile(__FILE__);

class CRatings extends CAllRatings
{
	function err_mess()
	{
		return "<br>Class: CRatings<br>File: ".__FILE__;
	}
	
		// insert result calculate rating   
	function AddResults($arResults)
	{
		global $DB;
		$err_mess = (CRatings::err_mess())."<br>Function: AddComponentResults<br>Line: ";		
		
		// Only Mysql
		$strSqlPrefix = "
				INSERT INTO b_rating_results
				(RATING_ID, ENTITY_TYPE_ID, ENTITY_ID, CURRENT_VALUE, PREVIOUS_VALUE)
				VALUES
		";
		$maxValuesLen = 2048;
		$strSqlValues = "";

		foreach($arResults as $arResult)
		{
			$strSqlValues .= ",\n(".IntVal($arResult['RATING_ID']).", '".$DB->ForSql($arResult['ENTITY_TYPE_ID'])."', '".$DB->ForSql($arResult['ENTITY_ID'])."', '".$DB->ForSql($arResult['CURRENT_VALUE'])."', '".$DB->ForSql($arResult['PREVIOUS_VALUE'])."')";
			if(strlen($strSqlValues) > $maxValuesLen)
			{
				$DB->Query($strSqlPrefix.substr($strSqlValues, 2), false, $err_mess.__LINE__);
				$strSqlValues = "";
			}
		}
		if(strlen($strSqlValues) > 0)
		{
			$DB->Query($strSqlPrefix.substr($strSqlValues, 2), false, $err_mess.__LINE__);
			$strSqlValues = "";
		}
		
		return true;
	}
	
	// insert result calculate rating-components  	
	function AddComponentResults($arComponentConfigs)
	{
		global $DB;
		$err_mess = (CRatings::err_mess())."<br>Function: AddComponentResults<br>Line: ";		
		
		if (!is_array($arComponentConfigs)) 
			return false;	
			
		$strSql  = "
			UPDATE b_rating_component 
			SET LAST_CALCULATED = ".$DB->GetNowFunction().", 
				NEXT_CALCULATION = '".date('Y-m-d H:i:s', time()+$arComponentConfigs['REFRESH_INTERVAL'])."'
			WHERE COMPLEX_NAME = '".$arComponentConfigs['COMPLEX_NAME']."'";
		$DB->Query($strSql, false, $err_mess.__LINE__);
		
		return true;
	}
}
?>