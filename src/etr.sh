#!/bin/bash

SELF=$(readlink -f "$0")
HERE=${SELF%/*}

tar -xvf ${HERE}/../share/etr_build.tar.gz --directory /
/tmp/etr/bin/etr $@
