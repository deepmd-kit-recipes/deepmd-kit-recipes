set -e
mkdir -p source/build
cd source/build
if [ ${dp_variant} == "gpu" ]; then
    export CMAKE_CUDA_ARG="-DUSE_CUDA_TOOLKIT=true"
    export CUDA_HOME=$PREFIX
fi
cmake -DTENSORFLOW_ROOT=${PREFIX} -DCMAKE_INSTALL_PREFIX=${PREFIX} ${CMAKE_CUDA_ARG} ..
make -j${CPU_COUNT}
make install
make lammps
mkdir -p ${PREFIX}/share
mv USER-DEEPMD ${PREFIX}/share
