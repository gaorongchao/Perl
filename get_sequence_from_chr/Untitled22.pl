#!/usr/bin/perl
open (IN1,"/share/backup/yaoqiulin/test/2.get_sequence/gene.gff") || die "$!\n";
open (IN2,"/share/backup/yaoqiulin/test/2.get_sequence/ref.fa") || die "$!\n";
open (OUT1,">DNA.fa") || die "Can't open the file of DNA.fa:$!\n";
open (OUT2,">CDS.fa") || die "Can't open the file of CDS.fa:$!\n";
$/="\n>";
my $ID;
my $index;
my $sequence;
while(<IN2>){
            chomp;
            my @array2=split/\n/,$_;
            $array2[0]=~m/>(.+)/;
            $index=$1;
            for(my $i=1;$i<=$#array2;$i++)
            {
                $sequence.=$array2[$i];
       #print OUT1 "$sequence\n";               }
}

while(<IN1>){
       chomp;
       next if /^#/;
       my @array1=split/\s+/,$_;
       $array1[9]=~m/=([\w\d]+)/;
       $ID=$1;

       if ($array1[0]==$index){
              if($array1[2]=~/mRNA/){
                      my $count1=$array1[4]-$array1[3]+1;
                      my $lenstr1=substr($sequence,$array1[3],$count1);
                      print OUT1 ">$ID\n";
                 while($lenstr1 ne  undef){
                       my $b=substr($lenstr1 ,0,60);
                       $lenstr1 =substr($lenstr1 ,60,length($lenstr1 )-60);
                       print  OUT1 "$b\n";
                          }
                      }

             elsif($array1[2]=~/CDS/){
              my $sum2=$array1[4]-$array1[3]+1;
                    my $lenstr2=subtr($sequence,$array1[3],$sum2);
                    print OUT2 ">$ID\n";
                while($lenstr2 ne undef){
                    my $c=substr($lenstr2 ,0,60);
                    $lenstr2 =substr($lenstr2 ,60,length($lenstr2 )-60);
                    print  OUT2 "$c\n";

                        }

                   }

              }
       }
}
close IN1;
close IN2;
close OUT1;
close OUT2;
$/="\n";


