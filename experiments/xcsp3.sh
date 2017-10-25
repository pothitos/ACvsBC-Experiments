#! /bin/sh
set -ev

#TODO: Patch solver to print CSP parameters

# Compile XCSP3 mini-parser
cd ../naxos-bounds-consistency/apps/XCSP3/
cmake .
make -j naxos-xcsp3
mv naxos-xcsp3 naxos-xcsp3.BC

# Compile against Arc Consistency solver
#TODO: Patch CMakeLists.txt with recipe for Naxos Arc Consistency
cmake .
make -j
mv naxos-xcsp3 naxos-xcsp3.AC
