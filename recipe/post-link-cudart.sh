#!/bin/bash

cat << EOF >> $PREFIX/.messages.txt

To enable CUDA support, UCX requires the presence of CUDA Runtime (libcudart).
The required package with the library needs to be installed manually.

* For CUDA 11, run:    conda install cuda-version=11 cudatoolkit
* For CUDA 12, run:    conda install cuda-version=12 cuda-cudart

EOF
