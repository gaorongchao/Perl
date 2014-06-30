use strict;
use warnings;
use utf8;
use Data::Dumper;


my	$out_out = "all_file_to_call_snp.txt";
open  my $out, '>', $out_out or die  "Fail open $out_out\n";
my $dir ="/home/wl/Data/data/rice/02.assembly/01.processed/00.local_data/00.pedigree/";
my @file = glob "$dir/*.bam";
foreach my $file (@file)
{
	print $out "$file\n";
}

=cut
opendir my ($dh),$dir;
my @new_paths=grep {!/^\.\.?\z/ }readdir $dh;
foreach my $new_path (@new_paths)
{
	my @file=glob "$dir/$new_path/*.bam";
	foreach my $file (@file)
	{
		print $out "$file\n";
	}
}
#print Dumper(\@new_paths);
#
my $dir1 ="/mnt/hdd1/rice/02.assembly/01.processed/01.published/";
opendir  my ($dh1),$dir1;
my @new_paths1=grep {!/^\.\.?\z/ }readdir $dh1;
print Dumper(\@new_paths1);
foreach my $new_path (@new_paths1)
{
	my $dir2="$dir1/$new_path/";
	opendir my ($dh2),$dir2;
	my @new_paths2=grep {!/^\.\.?\z/ }readdir $dh2;
	foreach my $new_path2 (@new_paths2)
	{
		my @file=glob "$dir1/$new_path/$new_path2/*.bam";
		foreach my $file (@file)
		{
			print $out "$file\n";
		}
	}
}
=cut
close  $out;
