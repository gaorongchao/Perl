#-------------------------------------------------------------------------------
#family_classify.pl--classify of the gene family
#                            Nowind, 2010.08.10
#-------------------------------------------------------------------------------


#--------------------------------------Main-------------------------------------

#!/usr/bin/perl -w
use strict;
use File::Find::Rule;
use Tie::File;
use Fcntl 'O_RDONLY';
use Data::Dumper;

open (F, "< pear_2.NBS.cds.fasta") || die "error: $! $:";  #fasta file
my %gene_length = ();
my $count       = 1;
while (<F>)
{
    print "\r$count";
    $count++;
    />(.+)/;
    $gene_length{$1} = length <F>;
}
close F;
print "\n";


my	$in_in = "pear.cds.NBS.fasta";
open  my $in, '<', $in_in or die "cannot open\n";
while(<$in>)
{
	chomp;
	$_=~m/>(.+)/;
	$gene_length{$1} =length <$in>;
}
close  $in;


#-------------------------------------------------------------------------------
#classify of the gene family
#-------------------------------------------------------------------------------

open (F, "< blast_result.txt.fas") || die "error: $! $:"; #blast result
my %name     = ();
my %coverage = ();
my %identity = ();
my %sum      = ();
while (my $ln = <F>)
{
    print "\rread line $.";
    my @line = split /\s+/, $ln;
    next if ($line[0] eq $line[1]) || ($name{$line[1]}->{$line[0]});
    next if !($gene_length{$line[0]} && $gene_length{$line[1]});

    $name{$line[0]}->{$line[1]} = 1;
    chomp $ln;
	$coverage{$line[0]}->{$line[1]}->[0] += $line[3]/$gene_length{$line[0]}; 
    $coverage{$line[0]}->{$line[1]}->[1] += $line[3]/$gene_length{$line[1]};
    $identity{$line[0]}->{$line[1]} += $line[2] * $line[3];
    $sum{$line[0]}->{$line[1]} += $line[3];
}
close F;

#-------------------------------------------------------------------------------

print "\n";
open (F, "< blast_result.txt.fas") || die "error: $! $:"; #blast result
my %gene_id = ();
my %pair    = ();
   %name    = ();
while (my $ln = <F>)
{
    
    my @line = split /\s+/, $ln;
    next if ($line[0] eq $line[1]) || ($name{$line[1]}->{$line[0]});
    next if !($gene_length{$line[0]} && $gene_length{$line[1]});
    
    $name{$line[0]}->{$line[1]} = 1;
    my $identity = $identity{$line[0]}->{$line[1]}/$sum{$line[0]}->{$line[1]};  
    if ($coverage{$line[0]}->{$line[1]}->[0] >= 0.80 &&    #coverage
        $coverage{$line[0]}->{$line[1]}->[1] >= 0.80 && $identity>=98.0) { #identity
        print "\rfilter $.";
        $pair{$line[0]}->{$line[1]} = 1;
        $gene_id{$line[0]}++;
        $gene_id{$line[1]}++;
    }
}
close F;

#-------------------------------------------------------------------------------

print "\nstart classifying...\n";
open (W, "> gene_family_0.8_98.csv") || die "error: $! $:"; #output file
my $family_count = 0;
my %checked      = ();
my %family       = ();
my @gene_name    = sort { $a cmp $b } keys %gene_id;
for (my $i=0; $i<$#gene_name; $i++)
{
    next if $checked{$gene_name[$i]};
    
    push @{$family{$family_count}}, $gene_name[$i];
    find_related_gene($gene_name[$i]); 
    $checked{$gene_name[$i]} = 1;
    
    for (@{$family{$family_count}})
    {
        find_related_gene($_);
    }
    
    $family_count++;
    print "\r$family_count";
}

for my $count (sort { $a <=> $b } keys %family)
{
    print W "family$count, ";
    print W "$_, " for @{$family{$count}};
    print W "\n";
}
close W;
print "\ndone!";

#--------------------------------------Sub--------------------------------------

sub find_related_gene
{
    my $gene = shift;
    for (my $i=0; $i<=$#gene_name; $i++)
    {
        next if $checked{$gene_name[$i]};

        if ($pair{$gene}->{$gene_name[$i]} || $pair{$gene_name[$i]}->{$gene}) {
            push @{$family{$family_count}}, $gene_name[$i];
            $checked{$gene_name[$i]} = 1;
        }
    }
}

#--------------------------------------End--------------------------------------
