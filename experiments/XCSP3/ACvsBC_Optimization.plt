#!/usr/bin/gnuplot

set border 3
set tics nomirror
set logscale xy

set xlabel "f(len, n, d, e)"
set ylabel "COST_{AC} / COST_{BC}"

f(len, n, d, e) = len / n

plot "results/CompetitionInstancesOptimization.dat" using \
    (f($2, $3, $4, $5)):($8 / $9) notitle
