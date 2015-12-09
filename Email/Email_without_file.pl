use strict;
use warnings;
use utf8;
use IO::Socket::SSL qw(SSL_VERIFY_NONE);

smtp_mailto('awe99081123@163.com','oK','no')

sub smtp_mailto
{
	use Net::SMTP::SSL;
	#use Net::SSLGlue::SMTP;
	my ($mail_to, $mail_subject, $mail_content) = @_; 
	my $sendAccount = '513428834@qq.com';
	my $sendAccountPw ='********';
	my $mail_cc = '513428834@qq.com';
	 
	my $smtp = Net::SMTP::SSL->new(
	'smtp.qq.com',
	Hello=>'HELLO',
	#SSL =>1,
	Port=>465,
	LocalPort=>0,
	Debug=>1);
	 
	die("smtp undefined: $@") if !defined $smtp;
	 
	my $auth_return = $smtp->auth($sendAccount,$sendAccountPw);
	die("auth error: $@") if !defined $auth_return;
	 
	$smtp->mail($sendAccount);
	$smtp->to($mail_to);
	$smtp->cc($mail_cc);
#$smtp->bcc($mail_bcc);
	$smtp->data();
	$smtp->datasend("From: $sendAccount\n");
	$smtp->datasend("To: $mail_to\n");
	$smtp->datasend("Subject: $mail_subject\n");
	$smtp->datasend("\n");
	$smtp->datasend("$mail_content");
	$smtp->datasend("\n");
	$smtp->dataend();
	$smtp->quit;
}
close  $out;
