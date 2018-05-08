<?
if(!defined("B_PROLOG_INCLUDED") || B_PROLOG_INCLUDED!==true)die();

$voteRand = time()+rand(0, 1000);
$voteTitle = $arParams['TOTAL_VOTES'] == 0 ? GetMessage("RATING_COMPONENT_NO_VOTES") : sprintf(GetMessage("RATING_COMPONENT_DESC"), $arParams['TOTAL_VOTES'], $arParams['TOTAL_POSITIVE_VOTES'], $arParams['TOTAL_NEGATIVE_VOTES']);
$voteId = $arParams['ENTITY_TYPE_ID'].'-'.$arParams['ENTITY_ID'].'-'.$voteRand;

?>
<span id="rating-vote-<?=$voteId?>" class="rating-vote<?=($arParams['USER_HAS_VOTED'] == 'Y' ? ' rating-vote-disabled' : '')?>">
	<a id="rating-vote-<?=$voteId?>-plus" class="rating-vote-plus"  onclick="<?=($arParams['USER_HAS_VOTED'] == 'N' ? "RatingVoting('".CUtil::JSEscape($arParams['ENTITY_TYPE_ID'])."', '".CUtil::JSEscape($arParams['ENTITY_ID'])."',  '".CUtil::JSEscape($voteRand)."', 'plus');" : '')?>return false;" title="<?=GetMessage("RATING_COMPONENT_PLUS")?>" href="#plus"></a>&nbsp;<a id="rating-vote-<?=$voteId?>-minus" class="rating-vote-minus" onclick="<?=($arParams['USER_HAS_VOTED'] == 'N' ? "RatingVoting('".CUtil::JSEscape($arParams['ENTITY_TYPE_ID'])."', '".CUtil::JSEscape($arParams['ENTITY_ID'])."',  '".CUtil::JSEscape($voteRand)."', 'minus');" : '')?>return false;" title="<?=GetMessage("RATING_COMPONENT_MINUS")?>" href="#minus"></a>
	<span id="rating-vote-<?=$voteId?>-result" class="rating-vote-result rating-vote-result-<?=($arParams['TOTAL_VALUE'] < 0 ? 'minus' : 'plus')?>" title="<?=$voteTitle?>"> <?=$arParams['TOTAL_VALUE']?></span>
</span> 