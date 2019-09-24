#!/bin/bash

set -xeuo pipefail

CUDA_CONFIG_ARG=""
if [ ${cuda_compiler_version} != "None" ]; then
    CUDA_CONFIG_ARG="--with-cuda"
fi

cd "${SRC_DIR}/ucx-py"
$PYTHON setup.py build_ext ${CUDA_CONFIG_ARG} install
