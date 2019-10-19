#!/bin/bash

cp -r ${PREFIX}/share/USER-DEEPMD src/
mkdir build
cd build
cmake -D PKG_USER-DEEPMD=ON -D FFT=FFTW3 -D CMAKE_INSTALL_PREFIX=${PREFIX} -D CMAKE_CXX_FLAGS="-DHIGH_PREC -I${PREFIX}/include -I${PREFIX}/include/deepmd -L${PREFIX}/lib -Wl,--no-as-needed -lrt -ldeepmd_op -ldeepmd -ltensorflow_cc -ltensorflow_framework -Wl,-rpath=${PREFIX}/lib" ../cmake
make -j${NUM_CPUS}
make install
cd ..
