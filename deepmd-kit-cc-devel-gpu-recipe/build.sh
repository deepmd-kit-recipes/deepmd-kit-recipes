mkdir source/build
cd source/build
touch ${PREFIX}/include/absl/numeric/int128_have_intrinsic.inc
cmake -DTENSORFLOW_ROOT=${PREFIX} -DCMAKE_INSTALL_PREFIX=${PREFIX} ..
make -j${nproc}
make install
make lammps
mkdir -p ${PREFIX}/share
mv USER-DEEPMD ${PREFIX}/share
