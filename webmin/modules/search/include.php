<?
if(!defined("CACHED_b_search_tags")) define("CACHED_b_search_tags", 3600);
if(!defined("CACHED_b_search_tags_len")) define("CACHED_b_search_tags_len", 2);

require_once($_SERVER["DOCUMENT_ROOT"]."/webmin/modules/search/tools/stemming.php");
require_once($_SERVER["DOCUMENT_ROOT"]."/webmin/modules/search/tools/tags.php");

global $DB;
$db_type = strtolower($DB->type);
CModule::AddAutoloadClasses(
	"search",
	array(
		"CSearchCallback" => "classes/general/search.php",
		"CSearch" => "classes/".$db_type."/search.php",
		"CSearchQuery" => "classes/".$db_type."/search.php",
		"CSiteMap" => "classes/".$db_type."/sitemap.php",
		"CSearchCustomRank" => "classes/general/customrank.php",
		"CSearchTags" => "classes/general/tags.php",
		"CSearchSuggest" => "classes/".$db_type."/suggest.php",
		"CSearchStatistic" => "classes/general/statistic.php",
	)
);

function GenerateUniqId($sName)
{
	static $arPostfix = array();

	$sPostfix = rand();
	while(isset($arPostfix[$sPostfix]))
		$sPostfix = rand();

	$arPostfix[$sPostfix] = 1;

	return preg_replace("/\W/", "_", $sName).$sPostfix;
}

?>