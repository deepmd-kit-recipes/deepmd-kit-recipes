# DeePMD-kit conda recipes

## Install packages

Create an environment named `deepmd`:
```sh
conda create -n deepmd deepmd-kit-devel-gpu -c njzjz
```

If you want to specify the version of CUDA or TensorFlow, execute the following command instead:
```sh
conda create -n deepmd deepmd-kit-devel-gpu cudatoolkit=10.1 tensorflow-gpu=1.14 -c njzjz
```

To use the environment, type:

```sh
source activate deepmd
```

Before using DeePMD-kit, set the following environment variable for [the best performance](https://www.tensorflow.org/guide/performance/overview):
```sh
export KMP_BLOCKTIME=0
export KMP_AFFINITY=granularity=fine,verbose,compact,1,0
```

Then
```sh
python -m deepmd train some.json
```

## Build from recipes

```sh
conda build deepmd-kit-devel-recipe/ -c njzjz
```

If you want to specify the version of Tensorflow, just modify `deepmd-kit-devel-recipe/conda_build_config.yaml`.

After building, type the following command to install DeePMD-kit.
```sh
conda install deepmd-kit-devel-recipe --use-local
```
