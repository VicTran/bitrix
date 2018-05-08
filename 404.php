<?
include_once($_SERVER['DOCUMENT_ROOT'].'/webmin/modules/main/include/urlrewrite.php');

CHTTP::SetStatus("404 Not Found");
@define("ERROR_404","Y");

require($_SERVER["DOCUMENT_ROOT"]."/webmin/header.php");

$APPLICATION->SetTitle("404 Not Found");

$APPLICATION->IncludeComponent("webmin:main.map", ".default", Array(
	"LEVEL"	=>	"3",
	"COL_NUM"	=>	"2",
	"SHOW_DESCRIPTION"	=>	"Y",
	"SET_TITLE"	=>	"Y",
	"CACHE_TIME"	=>	"36000000"
	)
);

require($_SERVER["DOCUMENT_ROOT"]."/webmin/footer.php");?>