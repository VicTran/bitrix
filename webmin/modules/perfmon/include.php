<?
global $DB;
$db_type = strtolower($DB->type);
require_once($_SERVER["DOCUMENT_ROOT"]."/webmin/modules/perfmon/classes/".$db_type."/keeper.php");
?>