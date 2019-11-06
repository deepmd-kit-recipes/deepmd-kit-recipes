set -e
mkdir -p source/build
cd source/build
cmake -DTENSORFLOW_ROOT="$PREFIX" -DCMAKE_INSTALL_PREFIX="$PREFIX" -DFLOAT_PREC="$float_prec" ..
make -j"$CPU_COUNT"
make install
make lammps
mkdir -p "$PREFIX"/share
mv USER-DEEPMD "$PREFIX"/share
