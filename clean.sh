#!/bin/bash
export BOOST_VERSION=boost_1_58_0
echo "Running scons to clean tools."
cd v2
source build_bashrc
scons -c
