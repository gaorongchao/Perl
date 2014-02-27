use strict;
use warnings;
use utf8;
use Data::Dumper;

sub data_for_path
{
	my $path = shift;
	if (-f $path or -l $path) # -f 判断file -l 判断link
	{
		return undef;
	}
	if (-d $path) # -d 判断文件夹
	{
		my %directory;
		opendir PATH,$path or die "Cannot opendir $path:$!";
		my @names = readdir PATH;
		closedir PATH;
		for my $name (@names)
		{
			next if $name eq '.' or $name eq '..'; # 排除. 和.. 文件
			$directory{$name} = data_for_path("$path/$name");
		}
		return \%directory;
	}
	warn "$path is neither a file nor a directory\n";
	return undef;
}

# 只需要给定一个目录名称
# 结果是一个引用
print Dumper(data_for_path("BioPerl"));

my %data;
sub dump_data_for_path
{
	my $path = shift;
	my $data = shift;

	if (not defined $data)
	{
		print "$path\n";
		return;
	}
	foreach (sort keys %{$data})
	{
		dump_data_for_path("$path/$_",$$data{$_}); # 这个地方是$$
	}
}

dump_data_for_path("BioPerl",data_for_path("BioPerl"));

=cut
# another way
sub dump_data_for_path
{
	my $path = shift;
	my $data = shift;

	if (not defined $data)
	{
		print "$path\n";
		return;
	}
	my %directory = %$data;

	foreach (sort keys %directory)
	{
		dump_data_for_path("$path/$_",$directory($_)); # 这个地方是$$
	}
}
