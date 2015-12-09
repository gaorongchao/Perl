use strict;
use warnings;
use utf8;
use Net::SMTP::SSL;
use MIME::Lite;


# 存在的问题，发送的中文在foxmail中乱码
#
#------------------------------------------------------
# Part 1 SQL
#------------------------------------------------------

#------------------------------------------------------
# Part 2 Mail
#------------------------------------------------------
my  $mail_from = "gaorongchao\@ebaoyang.cn";
my  $mail_to = "gaorongchao\@ebaoyang.cn";
my  $mail_cc = "gaorongchao\@ebaoyang.cn";
my  $username = "gaorongchao\@ebaoyang.cn";
my  $password = "***********";
my  $mail_subject ="zhongwen";

SendAttachMail("zhengwen",'bolishui_each_week.txt');

sub SendAttachMail
{
	my $mail_content = shift;
	my $mail_attach = shift;
	my $smtp = Net::SMTP::SSL->new(
		'smtp.exmail.qq.com',
		Hello=>'gaorongchao.org',
		Port=>465,
		LocalPort=>0,
		Debug=>1);
	die("smtp undefined: $@") if !defined $smtp;
	my $auth_return = $smtp->auth($username,$password);
	die("auth error: $@") if !defined $auth_return;
	my @tmp = split/\\/,$mail_attach;
	my $attach_name = pop(@tmp);
	my $msg=MIME::Lite->new(
		From=>$mail_from,
		To=>$mail_to,
		Cc=>$mail_cc,
		Subject=>$mail_subject,
		Type=>'TEXT',
		Encoding => 'base64',
		Data=>$mail_content,);
	$msg->attach(
		Type=>'AUTO',
		Path=>$mail_attach,
		Filename=>$attach_name,);
	my $content_string=$msg->as_string() or die "$!";
	$smtp->mail($mail_from);
	$smtp->to($mail_to);
	$smtp->data();
	$smtp->datasend($content_string);
	$smtp->dataend();
	$smtp->quit;
}
