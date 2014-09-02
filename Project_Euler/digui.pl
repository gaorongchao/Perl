#! /usr/bin/perl
use strict;
use warnings;
 
sub fac
{
    my $n = $_[0]; #注意此处，也可以些微my $n = shift()或者是my ($n) = @_;
    if(1 == $n)
    {
        return 1;
    }
    else
    {
        return ($n * fac($n - 1));
    }
}
 
print "Please input a number:";
chomp (my $n = <STDIN>); #请注意此处n的范围。
my $result = fac($n);
print "$n! = $result\n";

