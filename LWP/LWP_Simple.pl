use strict;
use warnings;
use utf8;
use File::Basename;
use Data::Dumper;
use LWP::Simple;


my	$out_out = "result.txt";
open  my $out, '>', $out_out or die  "Fail open $out_out\n";
my $url="http://baidu.com";
my $status=getstore("http://baidu.com","a.html");
my ($type,$length,$mod)=head($url);
my $is_success=head($url);
print $out Dumper($is_success);
print $out "$type $length $mod\n";
close  $out;
