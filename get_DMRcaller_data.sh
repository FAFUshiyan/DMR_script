grep -v 'pos' $1 |grep  $2 |awk '{print $1"\t"$2"\t"$3"\t"$7"\t"$8-$7"\t"$4"\t""CNN"}' > $3
grep -v 'pos' $1 |grep  $2 |awk '{print $1"#"$2"#"$3"#"$4"#""CNN"}' > $4
