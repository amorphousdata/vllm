#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

apt-get update -y
apt-get install -y git wget vim numactl gcc-12 g++-12 python3 python3-pip cmake
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-12 10 --slave /usr/bin/g++ g++ /usr/bin/g++-12

echo 'installing conda'
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm -rf ~/miniconda3/miniconda.sh

export PATH=$PATH:~/miniconda3/bin

conda init zsh
conda create -n vllm python=3.11
conda activate vllm

echo 'installing vllm into conda env'

git clone https://github.com/amorphousdata/vllm
cd vllm
pip install --upgrade pip
pip install wheel packaging ninja setuptools>=49.4.0 numpy
pip install -v -r requirements-cpu.txt --extra-index-url https://download.pytorch.org/whl/cpu

export VLLM_TARGET_DEVICE=cpu
python3 setup.py install


