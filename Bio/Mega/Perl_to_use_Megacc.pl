use strict;
use warnings;
use utf8;
use 5.16.3;

my	$out_out = "file.txt";
open  my $out, '>', $out_out or die  "Fail open $out_out\n";
my @files = glob "*.fasta";
foreach my $file (@files)
{
	#print $out "D:\\Less_less_region\\$file\n";
	#exec("M6CC.exe -a huashu.mao -d $file -o $file.out");
	system ("M6CC.exe -a huashu.mao -d $file -o $file.out");
}
close  $out;
