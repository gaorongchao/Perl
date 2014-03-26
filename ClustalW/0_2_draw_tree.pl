use strict;
use warnings;
use utf8;
use File::Basename;

#my @dirs  = qw/30 60 70 80 3060 6070 7080/;
#my @dirs  = qw/test/;

#foreach my $dir (@dirs)
#{
#my @files = glob "*$dir/*.csv";
	my @files = glob "*.csv";
	foreach my $file (@files)
	{
		$file=~m/(.).csv/;
		my $out_name = "$1";
		system "clustalw2 -INFILE=$file -TYPE=DNA -TREE -BOOTSTRAP -OUTFILE=$out_name -OUTPUTTREE=phylip";
	}
#}
