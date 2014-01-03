use strict;
use warnings;
use Data::Dumper;
use Bio::SeqIO;

my $seqo_object=Bio::SeqIO->new(-file=>">result2.fasta",-format=>"genbank");
my $seqi_object=Bio::SeqIO->new(-file=>"Os01g0104900.fasta",-format=>"fasta");
while(my $seq_object=$seqi_object->next_seq)
{
	my $protein_obj=$seq_object->translate(-terminator=>"-",-unknown=>"_");
	# -terminator 是设置终止子用什么表示
	# -unknow 设置N
	# $protein_obj也是一个对象，里面有很多属性，我们看下面的输出
	print Dumper($protein_obj);
	# 我们还可以设置翻译的起始位置（因为一个序列有六个阅读框,分别从第1,2,3和反向互补的
	# 第1,2,3。默认是翻译的第一个。
	$protein_obj1=$seq_object->translate(-frame => 1);
}
