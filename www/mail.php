<?php

$to      = 'personne@example.com';
$subject = 'le sujet';
$message = 'Bonjour !';
$headers = 'From: webmaster@example.com' . "\r\n" .
'Reply-To: webmaster@example.com' . "\r\n" .
'X-Mailer: PHP/' . phpversion();

if(mail($to, $subject, $message, $headers)) {
    echo 'Message sent successfully! Look at <a href="http://192.168.33.10:8025">MailHog</a>';
} else {
    echo 'Error while sending test email. Check the SMTP configuration.';
}