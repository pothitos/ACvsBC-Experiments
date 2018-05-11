#!/usr/bin/gnuplot

# Settings for direct output to screen window
set termoption enhanced
set termoption dash

set border 3
set tics nomirror
set logscale y

set xlabel "f(n, d, e)"
set ylabel "TIME_{AC} / TIME_{BC}"

plot "results/CompetitionInstances.dat" using ($0):($5/$6) notitle
