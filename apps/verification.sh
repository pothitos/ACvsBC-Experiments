#! /bin/sh
set -ev
# Set parameters for small CSP instances
sed -i.bak 's/^\(NQUEENS_RANGE\)=.*/\1=$(seq 10 11)/' \
    ../experiments/experiments.sh
sed -i 's/^\(MAGIC_SQUARE_RANGE\)=.*/\1=$(seq 5 6)/' \
    ../experiments/experiments.sh
sed -i 's/^\(CREW_SCHEDULING_RANGE\)=.*/\1=OR-Library\/NW41.txt/' \
    ../experiments/experiments.sh
sed -i 's/^\(TSP_RANGE\)=.*/\1=$(seq 8 9)/' ../experiments/experiments.sh
# Execute the measurements
../experiments/experiments.sh > ACvsBC.dat
cat ACvsBC.dat
# Restore the original script
mv ../experiments/experiments.sh.bak ../experiments/experiments.sh
# Graphically plot the results
./ACvsBC.plt
# Clean up
rm ACvsBC.tex ACvsBC.eps
