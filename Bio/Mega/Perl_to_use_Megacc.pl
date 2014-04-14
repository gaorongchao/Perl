use strict;
use warnings;
use utf8;
use 5.16.3;

my @files = glob "*.fasta";
foreach my $file (@files)
{
	system ("M6CC.exe -a huashu.mao -d $file -o $file.out");
}
