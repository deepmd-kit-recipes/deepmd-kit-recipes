#!/bin/bash

mkdir -p ${PREFIX}/lib/
mkdir -p ${PREFIX}/include/

set -vex

# expand PREFIX in BUILD file
sed -i -e "s:\${PREFIX}:${PREFIX}:" tensorflow/core/platform/default/build_config/BUILD

mkdir -p ./bazel_output_base
export BAZEL_OPTS=""
export TF_NEED_MKL=0
export BUILD_OPTS="
    --copt=-march=nocona
    --copt=-mtune=haswell
    --copt=-ftree-vectorize
    --copt=-fPIC
    --copt=-fstack-protector-strong
    --copt=-O2
    --cxxopt=-fvisibility-inlines-hidden
    --cxxopt=-fmessage-length=0
    --linkopt=-zrelro
    --linkopt=-znow
    --verbose_failures
    --config=opt"
export TF_ENABLE_XLA=1

# Compile tensorflow from source
export PYTHON_BIN_PATH=${PYTHON}
export PYTHON_LIB_PATH=${SP_DIR}
export USE_DEFAULT_PYTHON_LIB_PATH=1

# additional settings
# do not build with MKL support
export CC_OPT_FLAGS="-march=nocona -mtune=haswell"
export TF_NEED_IGNITE=1
export TF_NEED_OPENCL=0
export TF_NEED_OPENCL_SYCL=0
export TF_NEED_COMPUTECPP=0
export TF_NEED_ROCM=0
export TF_NEED_MPI=0
export TF_DOWNLOAD_CLANG=0
export TF_SET_ANDROID_WORKSPACE=0
export TF_NEED_CUDA=0

./configure

bazel ${BAZEL_OPTS} build  ${BUILD_OPTS}  \
	//tensorflow:libtensorflow_cc.so
mkdir -p $PREFIX/lib
cp -d bazel-bin/tensorflow/libtensorflow_cc.so* $PREFIX/lib/
cp -d bazel-bin/tensorflow/libtensorflow_framework.so* $PREFIX/lib/
cp -d $PREFIX/lib/libtensorflow_framework.so.2 $PREFIX/lib/libtensorflow_framework.so
mkdir -p $PREFIX/include
mkdir -p $PREFIX/include/tensorflow
# copy headers
rsync -avzh --include '*/' --include '*.h' --include '*.inc' --exclude '*' bazel-genfiles/ $PREFIX/include/
rsync -avzh --include '*/' --include '*.h' --include '*.inc' --exclude '*' tensorflow/cc $PREFIX/include/tensorflow/
rsync -avzh --include '*/' --include '*.h' --include '*.inc' --exclude '*' tensorflow/core $PREFIX/include/tensorflow/
rsync -avzh --include '*/' --include '*' --exclude '*.cc' third_party/ $PREFIX/include/third_party/
rsync -avzh --include '*/' --include '*' --exclude '*.txt' bazel-work/external/eigen_archive/Eigen/ $PREFIX/include/Eigen/
rsync -avzh --include '*/' --include '*' --exclude '*.txt' bazel-work/external/eigen_archive/unsupported/ $PREFIX/include/unsupported/
rsync -avzh --include '*/' --include '*.h' --include '*.inc' --exclude '*' bazel-work/external/com_google_protobuf/src/google/ $PREFIX/include/google/
rsync -avzh --include '*/' --include '*.h' --include '*.inc' --exclude '*' bazel-work/external/com_google_absl/absl/ $PREFIX/include/absl/
