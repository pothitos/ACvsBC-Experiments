#!/bin/sh
set -e

cd ../apps/
echo "CSP\tParam\tn\td\te\tAC_Time\tBC_Time"
echo
echo
NQUEENS_RANGE=$(seq 10 15)
for PARAM in $NQUEENS_RANGE
do
    time -o AC_Time.txt -f "%e" ./nqueens.AC $PARAM > /dev/null
    time -o BC_Time.txt -f "%e" ./nqueens.BC $PARAM | tail -1 > n_d_e.txt
    echo "NQueens\t$PARAM\t$(cat n_d_e.txt)\t$(cat AC_Time.txt)\t$(cat \
          BC_Time.txt)"
done
echo
echo
CREW_SCHEDULING_RANGE=crew_scheduling/OR-Library/*
for PARAM in $CREW_SCHEDULING_RANGE
do
    time -o AC_Time.txt -f "%e" ./crew_scheduling.AC $PARAM > /dev/null
    time -o BC_Time.txt -f "%e" ./crew_scheduling.BC $PARAM | tail -1 > \
        n_d_e.txt
    echo "CrewSch\t$(basename $PARAM .txt)\t$(cat n_d_e.txt)\t$(cat \
          AC_Time.txt)\t$(cat BC_Time.txt)"
done
echo
echo
TSP_RANGE=$(seq 9 14)
for PARAM in $TSP_RANGE
do
    time -o AC_Time.txt -f "%e" ./tsp.AC TSP/HA30.pl $PARAM > /dev/null
    time -o BC_Time.txt -f "%e" ./tsp.BC TSP/HA30.pl $PARAM | tail -1 > \
        n_d_e.txt
    echo "TSP\t$PARAM\t$(cat n_d_e.txt)\t$(cat AC_Time.txt)\t$(cat BC_Time.txt)"
done
echo
echo
MAGIC_SQUARE_RANGE=$(seq 7 9)
for PARAM in $MAGIC_SQUARE_RANGE
do
    time -o AC_Time.txt -f "%e" ./magic_square.AC $PARAM > /dev/null
    time -o BC_Time.txt -f "%e" ./magic_square.BC $PARAM | tail -1 > n_d_e.txt
    echo "MagicSq\t$PARAM\t$(cat n_d_e.txt)\t$(cat AC_Time.txt)\t$(cat \
          BC_Time.txt)"
done
rm AC_Time.txt BC_Time.txt n_d_e.txt
