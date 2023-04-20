#!/bin/bash

set -xeuo pipefail

[[ ${target_platform} == "linux-64" ]] && targetsDir="targets/x86_64-linux"
[[ ${target_platform} == "linux-ppc64le" ]] && targetsDir="targets/ppc64le-linux"
[[ ${target_platform} == "linux-aarch64" ]] && targetsDir="targets/sbsa-linux"

export CFLAGS="${CFLAGS} -I${PREFIX}/${targetsDir}/include -L${PREFIX}/${targetsDir}/lib/stubs"

EXTRA_ARGS=""
if [ "${cuda_compiler_version}" != "None" ]; then
    EXTRA_ARGS="${EXTRA_ARGS} --with-cuda=${PREFIX}"
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
