#!/bin/sh
set -ev

# Ensure that the files aren't already patched
cd ../naxos/apps/XCSP3/
git reset --hard
# Patch solver to print CSP parameters
git apply ../../../XCSP3/patches/print-parameters.patch

# Compile XCSP3 mini-parser
cmake .
make -j naxos-xcsp3
mv naxos-xcsp3 naxos-xcsp3.BC
git reset --hard

# Compile against Arc Consistency solver
# TODO: Patch alternative propagation implementation
cmake .
make -j naxos-xcsp3
if [ "$CONTINUOUS_INTEGRATION" = "true" ]
then
    ctest -V
    mv naxos-xcsp3 naxos-xcsp3.AC
    cd ../../../XCSP3/
    # Perform experiments for a limited time frame
    sed -i.bak 's/40m/1m/' experiments.sh
    ./experiments.sh verification/CheckerSlowInstances.txt
    # Restore the original script
    mv experiments.sh.bak experiments.sh
    cd -
fi

# Forbid unimplemented propagators
cd ../../
git apply ../XCSP3/patches/mark-unimplemented-propagators.patch
cd -
cmake .
make -j naxos-xcsp3
mv naxos-xcsp3 naxos-xcsp3.AC
