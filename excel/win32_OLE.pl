use strict;
use warnings;
use 5.16.3;

ues Win32::OLE;
print "content-type:text/html;\n\n";
$excel_app=Win32::OLE->new("Excel.Application");
$excel_book=$excel_app->Workbooks->Open("win32.xls");
$excel_sheet=$excel_book->Worksheets(1);
foreach $col(1)
{
	foreach $row{1..100}
	{
		next unless defined $excel_sheet->Cells($row,$col)->{'Value'};
		$thisdata=$excel_sheet->Cells($row,$col)->{'Value'};
		print  "<table border=1><tr><td>$row 行的数据:$thisdata</td></tr></table>";
	}
}
$excel_book->Close;
