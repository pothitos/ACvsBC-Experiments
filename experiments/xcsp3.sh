#! /bin/sh
set -ev
# Compile XCSP3 mini-parser
cd ../naxos-bounds-consistency/apps/XCSP3/
cmake .
make -j naxos-xcsp3
