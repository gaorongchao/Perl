use MIME::Entity;
#my $date=`date`;
my $date = "玻璃水防冻液等";
chomp $date;
    
$top = MIME::Entity->build(Type    =>"multipart/mixed",
                           From    => "gaorongchao\@ebaoyang.cn",
                           To      => "gaorongchao\@ebaoyang.cn",
                           Subject => $date,
                           Data    => "DATA TEST...");

$top->attach(Path        => "log.txt",
             Type        => "TEXT",
             Encoding    => "base64");
$top->send;
