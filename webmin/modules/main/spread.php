<?
header("P3P: policyref=\"/webmin/p3p.xml\", CP=\"NON DSP COR CUR ADM DEV PSA PSD OUR UNR BUS UNI COM NAV INT DEM STA\"");
$cookie = base64_decode($_GET["s"]);
$key = $_GET["k"];
if(strlen($key)>0)
{
	$LICENSE_KEY = "";
	@include($_SERVER["DOCUMENT_ROOT"]."/webmin/license_key.php");
	if($LICENSE_KEY=="" || strtoupper($LICENSE_KEY)=="DEMO") 
		$LICENSE_KEY = "DEMO";

	$salt = $_SERVER["REMOTE_ADDR"]."|".@filemtime($_SERVER["DOCUMENT_ROOT"]."/webmin/modules/main/classes/general/version.php")."|".$LICENSE_KEY;
	if(md5($cookie.$salt)==$key)
	{
		$arr = explode(chr(2), $cookie);
		if(is_array($arr) && count($arr)>0)
		{
			foreach($arr as $str)
			{
				if(strlen($str)>0)
				{
					$ar = explode(chr(1),$str);
					setcookie($ar[0], $ar[1], $ar[2], $ar[3], $_SERVER["HTTP_HOST"], $ar[5]);
					
					//logout
					if(substr($ar[0], -5) == '_UIDH' && $ar[1] == '')
					{
						session_start();
						$_SESSION["SESS_AUTH"] = Array();
						unset($_SESSION["SESS_AUTH"]);
						unset($_SESSION["OPERATIONS"]);
						unset($_SESSION["SESS_PWD_HASH_TESTED"]);
					}
				}
			}
		}
	}
}
?>