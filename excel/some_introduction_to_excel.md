
内容来源：http://blog.csdn.net/caz28/article/details/7943530
现在很多数据是以Excel文件格式保存的，对人来讲修改添加都比较方便，但程序处理就比较麻烦。
要对Excel里的数据进行加工，首选VBA，Microsoft一家的东西，肯定最搭。
但不喜欢VBA的风格，还是用自己熟悉的其他语言解决，python的能处理csv的，但转来转去总不是太好。
也有写python的Excel处理模块，但都是python2.x的。
还好我机器上有Perl，就用Perl吧。
Perl上处理Excel有名的模块是Spreadsheet，刚开始我是在展讯的代码里看到的，还以为跟展讯（spreadtrum）有啥关系，后来才知道没有关系。
先给来段读Excel的代码：
```
#!/usr/bin/perl -w
#用Spreadsheet::ParseExcel 显示一个工作薄的所有表的内容。

use strict;  
use warnings;  
 
use Spreadsheet::ParseExcel;

my $file = 'Demo.xls';

my $book = Spreadsheet::ParseExcel::Workbook->Parse( $file);
my @sheets = @{ $book->{Worksheet} };  
foreach my $sheet ( @sheets ){  
    my $sheetName = $sheet->get_name();  
    print "工作表: $sheetName\n";  
 
    my ( $minRow, $maxRow ) = $sheet->row_range();  
    my ( $minCol, $maxCol ) = $sheet->col_range();  
 
    foreach my $row ( $minRow .. $maxRow ){  
        foreach my $col ( $minCol .. $maxCol ){  
            my $cell = $sheet->get_cell( $row, $col );  
            next unless $cell;  
            print " ($row,$col) ", $cell->value;  
        }  
        print "\n";  
    }  
} 
```

再来段写Excel的代码：
```
#!/usr/bin/perl -w
#用Spreadsheet::WriteExcel，生成乘法表，实际从第2行第2列开始，因为0行0列才是第一行第一列。

use strict;  
use warnings;  

use Spreadsheet::WriteExcel;

my $file = 'Demo_write.xls';
my $sheetName = 'My sheet';

my $book = new Spreadsheet::WriteExcel( $file );
my $sheet = $book->add_worksheet( $sheetName ); 

foreach my $row (1 .. 9){
	foreach my $col (1 .. 9){
		$sheet->write($row, $col, ($row * $col) );
	}
}

$book->close();
```
对这个不是太熟，但从目前我了解情况看，Spreadsheet只能分别读写，不能对一个工作簿既读又写。
如果想既读又写，还得找Microsoft，用OLE。
这里只是简单演示一下用法，还是像上面一样分别来看看读写操作，不混合读写。
用OLE读Excel：
```
#!/usr/bin/perl -w
#用OLE，显示一个工作薄的所有表的内容。

use strict;
use Win32::OLE qw(in with);
use Win32::OLE::Const 'Microsoft Excel';
$Win32::OLE::Warn = 3;                                # die on errors...
# get already active Excel application or open new
my $Excel = Win32::OLE->GetActiveObject('Excel.Application') || Win32::OLE->new('Excel.Application', 'Quit'); 

my $file = 'Demo.xls';
my $value = 0;

my $book = $Excel->Workbooks->Open( $file );
foreach my $Sheet (in $book->{Worksheets})
{
    my $sheetName = $Sheet->{Name};  
    print "工作表: $sheetName\n";  
 
 	my $minRow = 1;
 	my $maxRow = $Sheet->UsedRange->Rows->Count;
 	my $minCol = 1;
 	my $maxCol = $Sheet->UsedRange->Columns->Count; 
    printf("row,col:%d,%d\n",$maxRow,$maxCol);
    foreach my $row ( $minRow .. $maxRow ){  
        foreach my $col ( $minCol .. $maxCol ){        	
            my $cell_value = $Sheet->Cells($row,$col)->{Value};
            next unless defined $cell_value;  
            print " ($row,$col) ", $cell_value;  
        }  
        print "\n";  
    }  
} 
$book->Close();
$Excel->Quit();
```
用OLE写Excel：
```
#!/usr/bin/perl -w
#用OLE 操作excel，生成乘法表。

use strict;
use Win32::OLE qw(in with);
use Win32::OLE::Const 'Microsoft Excel';
$Win32::OLE::Warn = 3;                                # die on errors...

my $Excel = Win32::OLE->GetActiveObject('Excel.Application') || Win32::OLE->new('Excel.Application', 'Quit'); 

my $excelfile = "Demo4.xls";

my $Book = $Excel->Workbooks->Add();
   $Book->SaveAs($excelfile); #Good habit when working with OLE, save+often.
my $Sheet = $Book->Worksheets("Sheet1");
   $Sheet->Activate();
foreach my $row (1 .. 9){
	foreach my $col (1 .. 9){
        $Sheet->Cells($row,$col)->{Value} = ($row * $col);
    }
}
# my $Chart = $Sheet->ChartObjects->Add(200, 200, 200, 200);
$Book->Save();
$Book->Close();
$Excel->Quit();
```

到底用哪种好呢？这要看情况：
1.非windows环境，不能用OLE。多平台下，Spreadsheet可用性更好。
2.在windows下，同样水平的代码，用OLE效率更高一些。
3.Spreadsheet用起来更简单一些，OLE要考虑的东西要多些。

对一个约一万行左右，200多列的工作表进行读取并处理，Spreadsheet用了30s左右，OLE用了18s左右。
在Perl程序里处理Excel要注意，尽量少调用Excel的函数或变量。
如：
```
[plain] view plaincopy
$myCell = $sheet->get_cell( $row, $col );  
$aValue =$myCell->value;  
forearch .....{  
    if($myCell->value == ...){#here  
    ....  
    }  
}  
```

如果把#here行里的$myCell->value改为$aValue（保证代码运行正确情况下的修改），可以提高效率。
这样的修改有时能提高3、4倍的性能（这个依赖具体情况）。
还有一点要注意，Spreadsheet里行列是从0开始的，OLE里行列是从1开始的。
