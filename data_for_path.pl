use strict;
use warnings;
use utf8;
use Data::Dumper;

sub data_for_path
{
	my $path = shift;
	if (-f $path or -l $path)
	{
		return undef;
	}
	if (-d $path)
	{
		my %directory;
		opendir PATH,$path or die "Cannot opendir $path:$!";
		my @names = readdir PATH;
		closedir PATH;
		for my $name (@names)
		{
			next if $name eq '.' or $name eq '..';
			$directory{$name} = data_for_path("$path/$name");
		}
		return \%directory;
	}
	warn "$path is neither a file nor a directory\n";
	return undef;
}

# 只需要给定一个目录名称
print Dumper(data_for_path("BioPerl"));
