#!/usr/bin/gnuplot

set border 3
set tics nomirror

set xlabel "f(n, d, e)"
set ylabel "COST_{AC} / COST_{BC}"

f(n, d, e) = n

plot "results/CompetitionInstancesOptimization.dat" using \
    (f($3, $4, $5)):($8 / $9) notitle
