
#package Dog; 

#sub new {
   my $pkg = shift;
   my $name = shift;
   return bless {name => $name}, $pkg;
	#以后通过   $x->shout 这样的调用， 就会转化成 Dog::shout($x); 这样的调用。
	#所以perl面向对象的本质就是使用bless，把数据（标量）跟包绑定起来。
   # 一个hash，经过bless以后，就和一个包绑定了
} 

sub shout {
   my $self = shift;
   print "my name is " . $self->{name};
}
1;

#这个就是基本的类定义。

#调用是这样： my $x = Dog->new;    $x->shout();

my $x=Dog->shout("Babby");
print "$x\n";

#键是理解箭头符号补插参数的作用。
#$x->shout(...);  等于   Dog::shout($x, ...);   记住这个！！

