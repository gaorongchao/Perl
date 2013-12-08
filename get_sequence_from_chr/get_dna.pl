#!/usr/bin/perl -w
use strict;
open (IN1,"1.txt") || die "$!\n";
open (IN2,"2.txt") || die "$!\n";
open (OUT1,">DNA.fa") || die "Can't open the file of DNA.fa:$!\n";
open (OUT2,">CDS.fa") || die "Can't open the file of CDS.fa:$!\n";
$/="\n>";
my $ID;
my $xulie;
my $sum_mRNA=0;
my $sum_CDS=0;
my $i;
while(<IN1>){
       chomp;
       next if /^#/;
       my @array1=split/\s+/,$_;
       $array1[9]=~m/=([\w\d]+)/;
       $ID=$1;

    while(<IN2>){
           chomp;
           my @array2=split/\n/,$_;
           $array2[0]=~m/>(.+)/;
           $xulie=$1;
       if ($array1[0]==$xulie){
              if($array1[2]=~/mRNA/){
                      my $count1=$array1[4]-$array1[3];
                      $sum_mRNA+=$count1;
                      my $lenstr1=substr($array2[1],0,$sum_mRNA-1);

                 while($lenstr1 != undef){
                       my $b=substr($lenstr1 ,0,60);
                       $lenstr1 =substr($lenstr1 ,60,length($lenstr1 )-60);
                       print  OUT1 "\>$ID,$b\n";
                          }
                       }

             elsif($array1[2]=~/CDS/){
                    my $sum2=$array1[4]-$array1[3];
                    $sum_CDS+=$sum2;
                    my $lenstr2=subtr($array2[1],0,$sum_CDS-1);
               while($lenstr2 != undef){
                    my $c=substr($lenstr2 ,0,60);
                    $lenstr2 =substr($lenstr2 ,60,length($lenstr2 )-60);
                    print  OUT2 "\>$ID,$c\n";
                        }
                    }
              else {

                next;

                }
         }
}
}
close IN1;
close IN2;
close OUT1;
close OUT2;
