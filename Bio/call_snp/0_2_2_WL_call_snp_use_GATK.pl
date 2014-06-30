use strict;
use warnings;
use utf8;
use Data::Dumper;
use File::Basename;
use Parallel::ForkManager;

$pm = Parallel::ForkManager->new(4);

my	$in_in = "all_file_to_call_snp.txt";
open  my $in, '<', $in_in or die "Fail open $in_in file\n";
my @all=<$in>;
foreach my $line (@all)
{
	my $pid = $pm->start and next;
	chomp $line;

	$file=basename($line);
	$file=~m/(.+).bam$/;
	my $file1=$1;
	system "java -jar /home/wl/Data/biosoft/GenomeAnalysisTK-3.1-1/GenomeAnalysisTK.jar \
			-R /home/wl/Data/data/rice/ref/IRGSP-1.0.genome.fasta \
           -T HaplotypeCaller \
           -I $file1 \
           -nct 4 \
           --emitRefConfidence GVCF \
           --variant_index_type LINEAR \
           --variant_index_parameter 128000 \
           -o gvcf/$file1.hc.gvcf \
           > gvcf/$file1.hc.log 2>&1";
   $pm->finish;
}
close  $in;

=cut
find /home/wl/Data/data/rice/03.analysis/bam_files/*.bam | \
	sed 's/.bam$//' | xargs -n 1 -P 4 -I PREFIX \
	sh -c '
		echo "Start processing PREFIX "

		java -jar /home/wl/Data/biosoft/GenomeAnalysisTK-3.1-1/GenomeAnalysisTK.jar \
			-R /home/wl/Data/data/rice/ref/IRGSP-1.0_genome.fasta \
           -T HaplotypeCaller \
           -I PREFIX.bam \
           -nct 4 \
           --emitRefConfidence GVCF \
           --variant_index_type LINEAR \
           --variant_index_parameter 128000 \
           -o PREFIX.hc.gvcf \
           > PREFIX.hc.log 2>&1
	
		echo "Finished processing PREFIX"
	'

