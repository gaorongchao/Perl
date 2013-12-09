use strict;
use warnings;

my $file1="DG_sequence.txt";
my $file2="all.gene.fasta";
#用第二个文件，建库，result.txt是库的名称，然后用第一个文件到库里去blast。
system "formatdb -i $file2 -p F -o F -n result.txt";  
system "blastall -p blastn -i $file1  -d result.txt -e 0.1 -o blast_result.txt.fas -F F -a 2 -m 8 -b 1 -v 1";  
