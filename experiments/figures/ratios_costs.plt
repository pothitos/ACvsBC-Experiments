#! /usr/bin/gnuplot


#set  termoption  enhanced
#set  termoption  dash
set  terminal  epslatex color
set  output  "ratios_costs.tex"
set  size  0.66


set tics nomirror
set border 3

set  key  samplen 0
set  pointsize  1.2


set  xlabel  "$d / n$"
set  ylabel  "$\\mathrm{COST_{AC}} / \\mathrm{COST_{BC}}$"  offset 3

set  logscale  x
set  format    xy  "$\\scriptstyle{%g}$"


set  style line 100  linetype 2  linecolor 0
set  arrow  from 1,0.8  to  1,1.125  nohead  linestyle 100
set  arrow  from 0.1,1  to   2500,1  nohead  linestyle 100

set  label "$d < n$"  at 1,1.1  offset -0.75,0.25  right
set  label "$d > n$"  at 1,1.1  offset +0.75,0.25

set  label "AC efficient"  at 1000,1  rotate  offset 2,-0.5  right
set  label "BC efficient"  at 1000,1  rotate  offset 2,+0.5


plot "ACvsBC.dat"  index 0  using ($7/$6):($3/$5)  linestyle 8 \
                   title "\\small ITC instance:", \
               ""  index 1  using ($7/$6):($3/$5)  linestyle 9 \
                   title "\\small CELAR instance:"


set  output
