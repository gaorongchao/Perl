use strict;
use warnings;
use utf8;
use JSON;
use Data::Dumper;
use LWP::Simple;

my $html = get("http://api.plos.org/search?q=*%3A*&wt=json&fq=doc_type%3A%28section_editor+OR+academic_editor%29+AND+cross_published_journal_key%3APLoSONE&fl=doc_type%2Cae_name%2Cae_institute%2Cae_country%2Cae_subject&sort=ae_last_name+asc%2Cae_name+asc&rows=5&start=0&json.wrf=_jqjsp&_1395363628472=");

my $string = substr($html,7,length($html)-9);

my $hash_ref=from_json($string);


my	$out_out = "result1.txt";
open  my $out, '>', $out_out or die  "Fail open $out_out\n";

#my $all=$hash_ref->{'response'}{'docs'}[0];
my @all=@{$hash_ref->{'response'}{'docs'}};

print $#all."\n";
for my $i (0..$#all)
{
	#print $out Dumper($all[$i])."\n";;
	print $out "Name:     $all[$i]->{'ae_name'}\n";
	print $out "Institue: $all[$i]->{'ae_institute'}[0]\n";
	print $out "Country:  $all[$i]->{'ae_country'}[0]\n";
	print $out "Doc_type: $all[$i]->{'doc_type'}\n";
	my @subject=@{$all[$i]->{'ae_subject'}};
	print $out "Subject:  ";
	foreach my $subject (@subject)
	{
		print $out "$subject,";
	}
	print $out "\n\n";
}
close  $out;
