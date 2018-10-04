#!/usr/bin/gnuplot

set border 3
set tics nomirror
set logscale xy

set xlabel "f(len, n, d, d_{AVG}, e)"
set ylabel "COST_{AC} / COST_{BC}"

f(len, n, d, d_avg, e) = d / n
ratio(AC, BC) = AC / BC

stats "results/CompetitionInstancesOptimization.dat" index 0 using \
    (f($2, $3, $4, $5, $6)):(ratio($9, $10)) nooutput
plot "" index 0 using (f($2, $3, $4, $5, $6)):(ratio($9, $10)) notitle, \
     "" index 1 using (f($2, $3, $4, $5, $6)):(STATS_min_y) notitle, \
     "" index 2 using (f($2, $3, $4, $5, $6)):(STATS_max_y) notitle
