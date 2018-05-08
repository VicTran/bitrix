<?
define("NO_KEEP_STATISTIC", "Y");
define("NO_AGENT_STATISTIC","Y");
define("PUBLIC_AJAX_MODE", true); 

require($_SERVER["DOCUMENT_ROOT"]."/bitrix/modules/main/include/prolog_before.php");

$entityTypeId 	= $_REQUEST['ENTITY_TYPE_ID'];
$entityId 		= intval($_REQUEST['ENTITY_ID']);
$voteAction 	= $_REQUEST['VOTE_ACTION'] == 'plus' ? 'plus' : 'minus';
$userId 		= $USER->GetId();
if (empty($entityTypeId) || empty($entityId) || is_null($userId)) 
{
	echo '{"result" : "false"}';
	exit;
}

$arRatingResult = CRatings::GetRatingVoteResult($entityTypeId, $entityId, $USER->GetId());
if (empty($arRatingResult)) 
{
	$arRatingResult['USER_HAS_VOTED'] = $USER->IsAuthorized() ? "N" : "Y";
	$arRatingResult['TOTAL_VALUE'] = 0;
	$arRatingResult['TOTAL_VOTES'] = 0;
	$arRatingResult['TOTAL_POSITIVE_VOTES'] = 0;
	$arRatingResult['TOTAL_NEGATIVE_VOTES'] = 0;
}
if ($arRatingResult['USER_HAS_VOTED'] == 'Y') 
{
	echo '{"result" : "false"}';
	exit;
}

$arAdd = array(
	"ENTITY_TYPE_ID" => $entityTypeId,
	"ENTITY_ID" 	 => $entityId,
	"VALUE" 		 => $voteAction == 'plus' ? 1 : -1,
	"USER_IP" 		 => $_SERVER['REMOTE_ADDR'],
	"USER_ID" 		 => $USER->GetId(), 	
);
CRatings::AddRatingVote($arAdd);

$arRatingResult['TOTAL_VALUE'] = $arRatingResult['TOTAL_VALUE']+($voteAction == 'plus' ? 1 : -1);
$arRatingResult['TOTAL_VOTES'] = $arRatingResult['TOTAL_VOTES']+1;
$arRatingResult[($voteAction == 'plus' ? 'TOTAL_POSITIVE_VOTES' : 'TOTAL_NEGATIVE_VOTES')] = $arRatingResult[($voteAction == 'plus' ? 'TOTAL_POSITIVE_VOTES' : 'TOTAL_NEGATIVE_VOTES')]+1;

$path = str_replace(array("\\", "//"), "/", dirname(__FILE__)."/lang/".LANGUAGE_ID."/vote.php");
include_once($path);
$resultValue  = $arRatingResult['TOTAL_VALUE'];
$resultStatus = $resultValue < 0 ? 'minus' : 'plus';
$resultTitle  = sprintf(GetMessage("RATING_COMPONENT_DESC"), $arRatingResult['TOTAL_VOTES'], $arRatingResult['TOTAL_POSITIVE_VOTES'], $arRatingResult['TOTAL_NEGATIVE_VOTES']);

echo '{"result" : "true", "resultValue" : "'.$resultValue.'", "resultStatus" : "'.$resultStatus.'", "resultTitle" : "'.$resultTitle.'"}';

require($_SERVER["DOCUMENT_ROOT"]."/bitrix/modules/main/include/epilog_after.php");
?>