use strict;
use warnings;


open(IN,"in.gff") or die "$!";
open (OUT1,">genebody.bed") or die "$!";
open (OUT2,">five-UTR.bed") or die "$!";
open (OUT3,">three-UTR.bed") or die "$!";
open (OUT4,">CDS.bed") or die "$!";
#open (OUT5,">Intron.bed") or die "$!";
#open(OUT6,">upstream2k.bed")or die "$!";
#open(OUT7,">dowmstream2k.bed")or die "$!";


my $ID;
while(<IN>)
{
	chomp;
	next if /^#/;
	my @array=split/\s+/,$_;
	$array[8]=~m/=([\w\d]+)/;
	$ID=$1;
	if($array[2]=~/mRNA/)
	{
		print OUT1 "$ID\t$array[0]\t$array[6]\t$array[3]\t$array[4]\n";
    }
    elsif($array[2]=~/5'UTR/)
	{
		print OUT2 "$ID\t$array[0]\t$array[6]\t$array[3]\t$array[4]\n";
    }
    elsif($array[2]=~/3'UTR/)
	{
		print OUT3 "$ID\t$array[0]\t$array[6]\t$array[3]\t$array[4]\n";
    }
    elsif($array[2]=~/CDS/)
	{
		print OUT4 "$ID\t$array[0]\t$array[6]\t$array[3]\t$array[4]\n";
    }
	else
	{
		next;
	}
}
