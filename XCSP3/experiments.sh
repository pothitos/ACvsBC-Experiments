#!/bin/sh
set -e

cd ../naxos/apps/XCSP3
. verification/common_functions.sh
SOLUTION="solution.txt"

validate_if_solution_exists() {
    STATUS="$1"
    METHOD="$2"
    if [ -z "$STATUS" -o -z "$METHOD" ]
    then
        echo "Missing status and/or method arguments" >&2
        exit 1
    fi
    if [ "$(cat $SOLUTION)" = "s UNKNOWN" ]
    then
        echo "X" > ${METHOD}_Time.txt
    else
        validate_exit_status $STATUS
    fi
    COST=$(get_solution_cost)
    if [ ! -z "$COST" ]
    then
        if grep -q "\<maximize\>" $INSTANCE
        then
            COST=$(echo "1 / $COST" | bc -l)
        fi
    fi
    echo "$COST" > ${METHOD}_Cost.txt
}

INSTANCE_FILENAMES="$1"
if [ -z "$INSTANCE_FILENAMES" ]
then
    echo "Missing file with instances names argument" >&2
    exit 1
fi

echo "CSP\tlen\tn\td\td_avg\te\tAC_Time\tBC_Time\tAC_Cost\tBC_Cost"
echo
INSTANCE=$(mktemp)
for INSTANCE_ORIG in $(cat "$INSTANCE_FILENAMES")
do
    lzcat $INSTANCE_ORIG.lzma > $INSTANCE

    echo -n "$(basename $INSTANCE_ORIG .xml)\t$(wc -c < $INSTANCE)\t"
    echo -n "$(./naxos-xcsp3.params $INSTANCE)\t"

    set +e  # Temporarily allow errors
    time -o AC_Time.txt -f "%e" \
        timeout --preserve-status --kill-after=1m 40m \
        ./naxos-xcsp3.AC $INSTANCE > $SOLUTION
    STATUS=$?
    set -e
    if [ $STATUS -eq 1 ]
    then
        echo
        cat $SOLUTION
    elif [ $STATUS -eq 143 ]
    then
        echo "KILLED"
        cat $SOLUTION
    else
        validate_if_solution_exists $STATUS AC
        echo -n "$(cat AC_Time.txt)\t"

        set +e  # Temporarily allow errors
        time -o BC_Time.txt -f "%e" \
            timeout --preserve-status --kill-after=1m 40m \
            ./naxos-xcsp3.BC $INSTANCE > $SOLUTION
        STATUS=$?
        set -e
        validate_if_solution_exists $STATUS BC
        echo -n "$(cat BC_Time.txt)\t"

        echo "$(cat AC_Cost.txt)\t$(cat BC_Cost.txt)"
    fi
    rm -f $SOLUTION AC_Time.txt BC_Time.txt AC_Cost.txt BC_Cost.txt
done
rm $INSTANCE
