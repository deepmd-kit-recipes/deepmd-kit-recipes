set -e
mkdir -p source/build
cd source/build
if [${varient}=="gpu"]; then
    export CMAKE_CUDA_ARG="-DUSE_CUDA_TOOLKIT=true"
fi
cmake -DTENSORFLOW_ROOT=${PREFIX} -DCMAKE_INSTALL_PREFIX=${PREFIX} ${CMAKE_CUDA_ARG} ..
make -j${nproc}
make install
make lammps
mkdir -p ${PREFIX}/share
mv USER-DEEPMD ${PREFIX}/share
