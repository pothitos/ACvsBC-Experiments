#! /bin/sh
set -ev

# Ensure that the files aren't already patched
cd ../naxos-bounds-consistency/apps/XCSP3/
git checkout translator.h CMakeLists.txt
# Patch solver to print CSP parameters
git apply ../../../experiments/xcsp3-print-parameters.patch

# Compile XCSP3 mini-parser
cmake .
make -j naxos-xcsp3
mv naxos-xcsp3 naxos-xcsp3.BC

# Compile against Arc Consistency solver
#TODO: Patch CMakeLists.txt with recipe for Naxos Arc Consistency
cmake .
make -j
mv naxos-xcsp3 naxos-xcsp3.AC
