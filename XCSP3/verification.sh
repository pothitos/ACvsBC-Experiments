#!/bin/sh
set -ev

# Bounds Consistency
cd ../naxos/
git reset --hard
git apply ../XCSP3/patches/binarize-sum.patch
git apply ../XCSP3/patches/bounds-consistency.patch
# Compile
cd apps/XCSP3/
cmake .
make -j naxos-xcsp3
# Test
if [ "$CONTINUOUS_INTEGRATION" = "true" ]
then
    ctest -V
fi
# Patch solver to print CSP parameters
cd -
git apply ../XCSP3/patches/print-parameters.patch
# Compile
cd -
cmake .
make -j naxos-xcsp3
mv naxos-xcsp3 naxos-xcsp3.BC

# Arc Consistency
cd -
git reset --hard
git apply ../XCSP3/patches/binarize-sum.patch
git apply ../XCSP3/patches/arc-consistency-propagation.patch
git apply ../XCSP3/patches/arc-consistency.patch
# Compile
cd -
cmake .
make -j naxos-xcsp3
# Test
if [ "$CONTINUOUS_INTEGRATION" = "true" ]
then
    ctest -V
    # Test both AC and BC solvers
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
# Compile
cd -
cmake .
make -j naxos-xcsp3
mv naxos-xcsp3 naxos-xcsp3.AC
