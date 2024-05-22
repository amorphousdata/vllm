#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

# git clone https://github.com/amorphousdata/vllm
# mv vllm vllm-clone


# Add Docker's official GPG key:
sudo apt-get update -y
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

git clone https://github.com/vllm-project/vllm
cd vllm
git checkout v0.4.2
cp ../vllm-clone/Dockerfile.cpu . # Overwrite Dockerfile

docker build -f Dockerfile.cpu -t richarddli/vllm-cpu-env:v0.2 --shm-size=4g .

# sudo apt-get install -y git wget vim numactl gcc-12 g++-12 python3 python3-pip cmake
# sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-12 10 --slave /usr/bin/g++ g++ /usr/bin/g++-12

# echo 'installing conda'
# mkdir -p ~/miniconda3
# wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
# bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
# rm -rf ~/miniconda3/miniconda.sh

# export PATH=$PATH:~/miniconda3/bin

# conda init zsh
# source ~/.zshrc
# conda create -n vllm python=3.11
# conda activate vllm

# echo 'installing vllm into conda env'

# git checkout v0.4.2
# pip install --upgrade pip
# pip install wheel packaging ninja setuptools>=49.4.0 numpy
# pip install -v -r requirements-cpu.txt --extra-index-url https://download.pytorch.org/whl/cpu

# export VLLM_TARGET_DEVICE=cpu
# python3 setup.py install

# python3 -m vllm.entrypoints.openai.api_server --model casperhansen/llama-3-8b-instruct-awq --dtype half --api-key "grum-71db-z91jf"
