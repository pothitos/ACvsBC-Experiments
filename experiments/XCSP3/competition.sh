#! /bin/sh
set -ev

# Ensure that the files aren't already patched
cd ../naxos-bounds-consistency/apps/XCSP3/
git reset --hard
# Patch solver to print CSP parameters
git apply ../../../experiments/XCSP3/print-parameters.patch

# Compile XCSP3 mini-parser
cmake .
make -j naxos-xcsp3
mv naxos-xcsp3 naxos-xcsp3.BC

# Compile against Arc Consistency solver
git apply ../../../experiments/XCSP3/compile-arc-consistency.patch
# Disable unsupported element constraint
git apply ../../../experiments/XCSP3/disable-element.patch
# Disable unsupported division intensional constraints
git apply ../../../experiments/XCSP3/disable-unsupported-division.patch
# Disable unsupported modulo intensional constraints
git apply ../../../experiments/XCSP3/disable-unsupported-modulo.patch
cmake .
make -j naxos-xcsp3
mv naxos-xcsp3 naxos-xcsp3.AC
