#!/bin/sh
set -ev

# Ensure that the files aren't already patched
cd ../naxos/
git reset --hard
# Enforce plain Bounds Consistency
git apply ../XCSP3/patches/bounds-oriented-consistency.patch
# Patch solver to print CSP parameters
git apply ../XCSP3/patches/print-parameters.patch

# Compile XCSP3 mini-parser
cd apps/XCSP3/
cmake .
make -j naxos-xcsp3
mv naxos-xcsp3 naxos-xcsp3.BC

# Compile against Arc Consistency solver
cd ../../
git reset --hard
git apply ../XCSP3/patches/value-oriented-propagation.patch
git apply ../XCSP3/patches/value-oriented-consistency.patch
cd -
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
