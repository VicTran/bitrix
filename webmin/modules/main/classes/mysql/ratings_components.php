<?
require($_SERVER["DOCUMENT_ROOT"].BX_ROOT."/modules/main/classes/general/ratings_components.php");
IncludeModuleLangFile(__FILE__);

class CRatingsComponentsMain extends CAllRatingsComponentsMain
{	
	function CalcUserRatingForumActivity($arConfigs)
	{
		global $DB;

		$arComponentResults = array();
		
		$strSql = "
			SELECT USER_START_ID as ENTITY_ID, 
			       SUM(IF(TO_DAYS(START_DATE) > TO_DAYS(NOW())-1, 1, 0)) as TOPIC_DAY,
			       SUM(IF(TO_DAYS(START_DATE) > TO_DAYS(NOW())-7, 1, 0)) as TOPIC_WEEK,
			       COUNT(*) as TOPIC_MONTH
			FROM b_forum_topic
			WHERE START_DATE  >  DATE_ADD(NOW(), INTERVAL -30 DAY)
			GROUP BY USER_START_ID
		";
		$res = $DB->Query($strSql, false, $err_mess.__LINE__);
		while($arRes = $res->Fetch())
		{
			$arComponentResults[$arRes['ENTITY_ID']]['ENTITY_TYPE_ID']  = $arRes['ENTITY_ID'];
			$arComponentResults[$arRes['ENTITY_ID']]['TOTAL_VALUE']		= $arRes['TOPIC_DAY']*$arConfigs['CONFIG']['TODAY_TOPIC_COEF'] +
																		  $arRes['TOPIC_WEEK']*$arConfigs['CONFIG']['WEEK_TOPIC_COEF'] + 
													 					  $arRes['TOPIC_MONTH']*$arConfigs['CONFIG']['MONTH_TOPIC_COEF'];
		}

		$strSql = "
			SELECT AUTHOR_ID as ENTITY_ID, 
			       SUM(IF(TO_DAYS(POST_DATE) > TO_DAYS(NOW())-1, 1, 0)) as MESSAGE_DAY,
			       SUM(IF(TO_DAYS(POST_DATE) > TO_DAYS(NOW())-7, 1, 0)) as MESSAGE_WEEK,
			       COUNT(*) as MESSAGE_MONTH
			FROM b_forum_message
			WHERE POST_DATE  >  DATE_ADD(NOW(), INTERVAL -30 DAY)
			GROUP BY AUTHOR_ID
		";
		$res = $DB->Query($strSql, false, $err_mess.__LINE__);
		while($arRes = $res->Fetch())
		{
			if (is_set($arComponentResults[$arRes['ENTITY_ID']])) 
			{
				$arComponentResults[$arRes['ENTITY_ID']]['TOTAL_VALUE']  += $arRes['MESSAGE_DAY']*$arConfigs['CONFIG']['TODAY_POST_COEF'] +
																			$arRes['MESSAGE_WEEK']*$arConfigs['CONFIG']['WEEK_POST_COEF'] + 
														 					$arRes['MESSAGE_MONTH']*$arConfigs['CONFIG']['MONTH_POST_COEF'];
			} else {
				$arComponentResults[$arRes['ENTITY_ID']]['ENTITY_TYPE_ID']  = $arRes['ENTITY_ID'];
				$arComponentResults[$arRes['ENTITY_ID']]['TOTAL_VALUE']		= $arRes['MESSAGE_DAY']*$arConfigs['CONFIG']['TODAY_POST_COEF'] +
																			  $arRes['MESSAGE_WEEK']*$arConfigs['CONFIG']['WEEK_POST_COEF'] + 
													 						  $arRes['MESSAGE_MONTH']*$arConfigs['CONFIG']['MONTH_POST_COEF'];
			}
		}

		CRatings::AddComponentResults($arConfigs, $arComponentResults);
		
		return true;
	}
}
?>