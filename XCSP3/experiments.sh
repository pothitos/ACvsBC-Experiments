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
    get_solution_cost > ${METHOD}_Cost.txt
}

INSTANCE_FILENAMES="$1"
if [ -z "$INSTANCE_FILENAMES" ]
then
    echo "Missing file with instances names argument" >&2
    exit 1
fi

echo "CSP\tlen\tn\td\td_avg\te\tAC_Time\tBC_Time\tAC_Cost\tBC_Cost"
echo
INSTANCE_EXTRACTED=$(mktemp)
for INSTANCE in $(cat "$INSTANCE_FILENAMES")
do
    lzcat $INSTANCE.lzma > $INSTANCE_EXTRACTED

    echo -n "$(basename $INSTANCE .xml)\t$(wc -c < $INSTANCE_EXTRACTED)\t"
    echo -n "$(./naxos-xcsp3.params $INSTANCE_EXTRACTED)\t"

    set +e  # Temporarily allow errors
    time -o AC_Time.txt -f "%e" \
        timeout --preserve-status --kill-after=1m 40m \
        ./naxos-xcsp3.AC $INSTANCE_EXTRACTED > $SOLUTION
    STATUS=$?
    set -e
    validate_if_solution_exists $STATUS AC
    echo -n "$(cat AC_Time.txt)\t"

    set +e  # Temporarily allow errors
    time -o BC_Time.txt -f "%e" \
        timeout --preserve-status --kill-after=1m 40m \
        ./naxos-xcsp3.BC $INSTANCE_EXTRACTED > $SOLUTION
    STATUS=$?
    set -e
    validate_if_solution_exists $STATUS BC
    echo -n "$(cat BC_Time.txt)\t"

    echo "$(cat AC_Cost.txt)\t$(cat BC_Cost.txt)"
    rm $SOLUTION AC_Time.txt BC_Time.txt AC_Cost.txt BC_Cost.txt
done
rm $INSTANCE_EXTRACTED
