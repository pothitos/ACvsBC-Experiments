#!/usr/bin/gnuplot

set border 3
set tics nomirror
set logscale xy

set xlabel "f(len, n, d, e)"
set ylabel "TIME_{AC} / TIME_{BC}"

f(len, n, d, e) = d / n

plot "results/CompetitionInstances.dat" using (f($2, $3, $4, $5)):($6 / $7) \
     notitle
