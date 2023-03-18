#!/bin/bash

set -xeuo pipefail

EXTRA_ARGS=""
if [ "${cuda_compiler_version}" != "None" ]; then
    EXTRA_ARGS="${EXTRA_ARGS} --with-cuda=${CUDA_HOME}"
fi


# --with-rdmacm requires rdma-core v23+, while CentOS 7 only offers v22.

./autogen.sh
./contrib/configure-release \
    --build="${BUILD}" \
    --host="${HOST}" \
    --prefix="${PREFIX}" \
    --with-sysroot \
    --enable-cma \
    --enable-mt \
    --enable-numa \
    --with-gnu-ld \
    ${EXTRA_ARGS} || { cat config.log; exit 1; }


make -j${CPU_COUNT}
make install
