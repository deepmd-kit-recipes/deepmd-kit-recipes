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
