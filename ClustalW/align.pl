#!/usr/bin/perl -w
use strict;
use Bio::SeqIO;

my @files=glob "*.fas";
foreach my $file (@files){
    my (%cds,%prt);
    open OUT ,">protein.temp";
    #open CDS,">cds.temp";
    my $seqio = Bio::SeqIO->new( -format => 'fasta',-file   => $file );
    while (my $seq = $seqio->next_seq){
        my $name=$seq->display_id;
        my $gene=$seq->seq;
        
        $cds{$name}=$gene;
        #print CDS "$name\n$gene\n";
        print OUT ">$name\n";
        my $trans= $seq->translate();
         my $trans_out=$trans->seq;
        print OUT "$trans_out\n";
    }
    my $command="clustalw2 -INFILE=protein.temp -TYPE=PROTEIN -ALIGN -OUTFILE=align_protein.temp -OUTPUT=FASTA -QUIET";
    system $command;
    close OUT;
    open RW,">align_$file";
    my $prt=Bio::SeqIO->new( -format => 'fasta',-file   =>"align_protein.temp" );
    while (my $seq =$prt->next_seq){
        my $name=$seq->display_id;
        my $seq=$seq->seq;
        $prt{$name}=$seq;
        my $align;
        my $count=0;
        for (my $i=0;$i<=(length $seq)-1;$i++){
            my $aa=substr($seq,$i,1);
            if ($aa ne "-"){
                $align.=substr($cds{$name},$count,3);
                $count+=3;
            }else{
                $align.="---";
            }
        }
        print RW ">$name\n$align\n";
    }
}
unlink "protein.temp","align_protein.temp","protein.dnd";