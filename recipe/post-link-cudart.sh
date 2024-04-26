#!/bin/bash

cat << EOF >> $PREFIX/.messages.txt

To enable CUDA support, UCX requires the presence of CUDA Runtime (libcudart).
For CUDA 11 and below, this means the "cudatoolkit" package should be installed
in your conda environment. For CUDA 12 and above, it is "cuda-cudart". The required
package needs to be installed manually (versions can be set by also installing
the "cuda-version" package, e.g. "conda install cuda-version=12.3 cuda-cudart").

EOF
