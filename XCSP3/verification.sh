#!/bin/sh
set -ev

# Ensure that the files aren't already patched
cd ../naxos/apps/XCSP3/
git reset --hard
# Patch solver to print CSP parameters
git apply ../../../XCSP3/print-parameters.patch

# Compile XCSP3 mini-parser
cmake .
make -j naxos-xcsp3
mv naxos-xcsp3 naxos-xcsp3.BC
git reset --hard

# Compile against Arc Consistency solver
# TODO
# Disable unsupported element constraint
git apply ../../../XCSP3/disable-element.patch
# Disable unsupported division intensional constraints
git apply ../../../XCSP3/disable-unsupported-division.patch
# Disable unsupported modulo intensional constraints
git apply ../../../XCSP3/disable-unsupported-modulo.patch
cmake .
make -j naxos-xcsp3
if [ "$CONTINUOUS_INTEGRATION" = "true" ]
then
    ctest -V
fi
mv naxos-xcsp3 naxos-xcsp3.AC

if [ "$CONTINUOUS_INTEGRATION" = "true" ]
then
    cd -
    # Perform experiments for a limited time frame
    sed -i.bak 's/40m/1m/' experiments.sh
    ./experiments.sh verification/CheckerSlowInstances.txt
    # Restore the original script
    mv experiments.sh.bak experiments.sh
fi
