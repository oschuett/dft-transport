#!/bin/bash -e

source /opt/cp2k-toolchain/install/setup

set -x
mpiexec -np 2 transport gnr.inp
cat Transmission_1
echo "Reference for third value: -1.99999999503444"
#EOF
