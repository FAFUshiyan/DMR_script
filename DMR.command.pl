#!perl -w
$dir = $ARGV[0]."vs".$ARGV[2]."_200bp"; 
$dir =~ s/\.rep1\.C\.meth//g;
system ("mkdir $dir") ;
chdir "$dir"; 
system ("ln -s ../$ARGV[0]");
system ("ln -s ../$ARGV[1]");
system ("ln -s ../$ARGV[2]");
system ("ln -s ../$ARGV[3]");
chdir "../";
$input = `ls Mango.HiC.part-*.fasta`;
open (OT,">$dir/all.sh") or die "";
my $num = '0';
@db = split (/\n/,$input);
        foreach $i(0..$#db){
                $in = $db[$i];  
                $num ++;
                $out = $num.".dmr.sh";
                print OT "qsub $out\n";
        open (OUT,">$dir/$out") or die "";
        print OUT "\#\!\/bin\/bash\n\#PBS -l nodes=1:ppn=4\n\#PBS -N $dir.$num\n\#PBS -o log.out.$num\n\#PBS -e err.out.$num\n\#PBS -q four\ncd  \$PBS_O_WORKDIR\n";
        print OUT "\n";
        print OUT "perl /gpfsdata/Mango/Methylation/Result/DMR/getMango.DMR.pl $ARGV[0] $ARGV[1] $ARGV[2] $ARGV[3] ../$in\n";
        }
