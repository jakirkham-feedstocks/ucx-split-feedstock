#!/bin/bash

cat << EOF >> $PREFIX/.messages.txt

To enable CUDA support, UCX requires the CUDA Runtime library (libcudart).
The library can be installed with the appropriate command below:

* For CUDA 11, run:    conda install cuda-version=11 cudatoolkit
* For CUDA 12, run:    conda install cuda-version=12 cuda-cudart

EOF
