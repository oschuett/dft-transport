#!/bin/bash -e

source /opt/cp2k-toolchain/install/setup

set -x
mpiexec -np 2 transport gnr.inp
cat Transmission_1
echo "Reference for third value: -1.99999999503444"

lcov --directory /opt/omen/src/  --capture --output-file full_cov.info
lcov --remove full_cov.info /opt/cp2k-toolchain/\* --output-file cp2k-omen_cov.info
lcov --list cp2k-omen_cov.info
mkdir html
cd html
genhtml ../cp2k-omen_cov.info

#EOF
