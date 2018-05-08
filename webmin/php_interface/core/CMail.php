<?
/*
@copyright: V&V IDS, JSC.
http://vivicorp.com
email: lienhe@vivicorp.com
----------------------------
Vesion: 2.0.0
Last Update: 11.01.2012
Update by Ngocub
Add function custom mail.
Update phpMailer newer version
*/
define("HOST_SERVER_MAIL","smtp.gmail.com");
define("HOST_SERVER_MAIL_PORT","465");
define("SSL",true);
define("USER_NAME","pmpcn.sendmail@gmail.com");
define("PASSWORD","pmpcn@123");
define('MAIL_DEBUG','false');
class CMail{        
    function send_mail($from,$from_name,$to,$subject,$content)
    {	
		if(!class_exists('PHPMailer'))
		{
			require_once($_SERVER["DOCUMENT_ROOT"]."/bitrix/php_interface/business/class.phpmailer.php");
		}
		$mail = new PHPMailer();
    	$mail->IsSMTP();
    	//$mail->SetLanguage("vn", "");
    	$mail->Host     = HOST_SERVER_MAIL;
		$mail->Port     = HOST_SERVER_MAIL_PORT;
		$mail->SMTPAuth = true;
		if(MAIL_DEBUG){
			$mail->SMTPDebug = false;
		}
		if(SSL){
			$mail->SMTPSecure = "ssl";
		}
		$mail->CharSet  = 'UTF-8';
    	////////////////////////////////////////////////
    	// Ban hay sua cac thong tin sau cho phu hop
    	$mail->Username = USER_NAME;				// SMTP username
    	$mail->Password = PASSWORD; 				// SMTP password
    	$mail->From     = USER_NAME;				// Email duoc gui tu
    	$mail->FromName = $from_name." - Admin";					// Ten hom email duoc gui
        //$to = array("ngocub@vivicorp.com","trungnt@vivicorp.com");
		if(is_array($to)){
        foreach($to as $email){
            $mail->AddAddress($email,"");    //Dia chi email va ten nhan
        }}else{
			$mail->AddAddress($to,"");    //Dia chi email va ten nhan
		}
    	$mail->AddReplyTo($from,"Reply");		// Dia chi email va ten gui lai	
    	$mail->IsHTML(true);						// Gui theo dang HTML
    	$mail->Subject  =  $subject;				// Chu de email
    	$mail->Body     =  $content;		// Noi dung html
    	if(!$mail->Send())
    	{
    	   return false;
    	}
    	else
    	{
    		return true;
    	}
    }      
}
function custom_mail($to, $subject, $message, $additional_headers, $additional_parameters)
{
	if(!class_exists('PHPMailer'))
	{
		require_once($_SERVER["DOCUMENT_ROOT"]."/bitrix/php_interface/business/class.phpmailer.php");
	}
 	$mail = new PHPMailer();
	$mail->IsSMTP();
	$mail->SetLanguage("vn", "");
	$mail->Host     = HOST_SERVER_MAIL;
	$mail->Port = HOST_SERVER_MAIL_PORT;
	$mail->SMTPAuth = true;
	if(SSL){
		$mail->SMTPSecure = "ssl";
	}
    $additional_headers = $mail->HeaderLine('To', $mail->EncodeHeader($mail->SecureHeader($to))).$additional_headers;
    $additional_headers = $mail->HeaderLine('Subject', $mail->EncodeHeader($mail->SecureHeader($subject))).$additional_headers;
    $mail->Header = $additional_headers."\n";
	$mail->CharSet  = 'UTF-8';
	$mail->Username = USER_NAME;				// SMTP username
	$mail->Password = PASSWORD; 				// SMTP password
	$mail->AddAddress($to,"");
	$mail->IsHTML(true);						// Gui theo dang HTML
	$mail->Subject  =  $subject;				// Chu de email
	//$mail->From     = "sendmail.vivicorp@gmail.com";				// Email duoc gui tu???
	//$mail->FromName = "Admin";					// Ten hom email duoc gui
	
    $mail->Body = $message;
	return $mail->Send();
}
?>