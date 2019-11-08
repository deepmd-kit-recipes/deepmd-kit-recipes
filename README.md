# DeePMD-kit conda recipes

## Install packages

```sh
conda install deepmd-kit=*=*gpu lammps-dp=*=*gpu -c deepmodeling
```

Feels free to replace `gpu` with `cpu`.

```sh
dp -h
lmp -h
```
If you are in China, you can use the Tsinghua mirror instead the origin channel. Add the following to `~/.condarc`:
```yaml
default_channels:
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free
deepmodeling:
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/deepmodeling
```
