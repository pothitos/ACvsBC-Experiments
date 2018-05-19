#!/usr/bin/gnuplot

set border 3
set tics nomirror
set logscale y

set xlabel "f(n, d, e)"
set ylabel "TIME_{AC} / TIME_{BC}"

f(n, d, e) = n

plot "results/CompetitionInstances.dat" using (f($2, $3, $4)):($5 / $6) notitle
