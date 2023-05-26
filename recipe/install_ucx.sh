#!/bin/bash

set -xeuo pipefail

EXTRA_ARGS=""

if [[ "${cuda_compiler_version}" =~ 12.* ]]; then
  EXTRA_ARGS="${EXTRA_ARGS} --with-cuda=${PREFIX}"

  [[ ${target_platform} == "linux-64" ]] && targetsDir="targets/x86_64-linux"
  [[ ${target_platform} == "linux-ppc64le" ]] && targetsDir="targets/ppc64le-linux"
  [[ ${target_platform} == "linux-aarch64" ]] && targetsDir="targets/sbsa-linux"

  export CFLAGS="${CFLAGS} -I${BUILD_PREFIX}/${targetsDir}/include -L${BUILD_PREFIX}/${targetsDir}/lib/stubs"
elif [[ "${cuda_compiler_version}" != "None" ]]; then
  EXTRA_ARGS="${EXTRA_ARGS} --with-cuda=${CUDA_HOME}"
fi

if [ "${cuda_compiler_version}" != "10.2" ] && [ "${target_platform}" == "linux-64" ]; then
    EXTRA_ARGS="${EXTRA_ARGS} --with-rdmacm=${PREFIX} --with-verbs=${PREFIX}"
fi

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
