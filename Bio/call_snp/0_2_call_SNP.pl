use strict;
use warnings;
use utf8;
use File::Basename;
use Data::Dumper;

my $input;
my	$in_in = "all_file_to_call_snp3.txt";
open  my $in, '<', $in_in or die "Fail open $in_in file\n";
while(my $line=<$in>)
{
	chomp $line;
	$input=$input."-I $line ";
}
close  $in;
#print Dumper($input);

system "java -jar /home/wl/Data/biosoft/GenomeAnalysisTK-3.1-1/GenomeAnalysisTK.jar -R /home/wl/Data/data/rice/ref/IRGSP-1.0_genome.fasta -L snp_position.list -T UnifiedGenotyper -nt 16 $input  -o 1_sample.vcf  -stand_call_conf 30.0  -stand_emit_conf 30.0  -glm BOTH";
