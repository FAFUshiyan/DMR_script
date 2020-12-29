#!perl -w
my %hash;
open (FH,$ARGV[0]) or die "";
while(<FH>){
    chomp;
    my @F = split (/\s+/,$_);
        $u = $F[3]."-".$F[4];
        $hash{$F[0]}->{$F[1]} = $u;
}
close FH;
open (IN,$ARGV[1]) or die "";
while (<IN>){
chomp;
@p = split (/\s+/,$_);
if (exists ($hash{$p[0]}->{$p[1]})){
$u = $hash{$p[0]}->{$p[1]};
$u =~ s/-/\t/g;
print "$p[0]\t$p[1]\t$p[2]\t$u\t$p[3]\t$p[4]\n";
}else{
print "$p[0]\t$p[1]\t$p[2]\t0\t0\t$p[3]\t$p[4]\n";
}
}
close IN;
