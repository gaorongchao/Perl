use strict;
use warnings;
use 5.16.3;

use Spreadsheet::WriteExcel;
my $workbook=Spreadsheet::WriteExcel->new('perl.xls');
my $worksheet=$workbook->add_worksheet();
for my $i (1..5)
{
	my $m="A"."$i";
	$worksheet->write($m,'hello excell');
}

my $red_background=$workbook->add_format(
color    => 'white',
bg_color => "red",
bold     => 1,
);

my $bold=$workbook->add_format(bold=>1);
# (行,列)
$worksheet->write(0,1,'colored cell',$red_background);
$worksheet->write(1,1,'colored cell',$bold);

my $product_code='01235';
$worksheet->write_string(0,2,$product_code);

# 我们也可以利用Perl直接在excel中创建公式
$worksheet->write("B4",37);
$worksheet->write("B5",7);
$worksheet->write("B6",'=B4+B5');
