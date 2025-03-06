# Nvidia Spark Rapids Setup

## Requirements
A. NVIDIA Volta™ or higher GPU with compute capability 7.0+ 

B. Ubuntu 20.04 or 22.04, Rocky Linux 8, or WSL2 on Windows 11

C. Recent CUDA version and NVIDIA driver pairs. Check yours with: nvidia-smi

## Install Rapids with Conda

1. If not installed, download and run the install script.
This will install the latest miniconda:

    ```
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    bash Miniconda3-latest-Linux-x86_64.shCopy
    ```


2. Then quick install RAPIDS with:

    ```
    conda create -n rapids-24.08 -c rapidsai -c conda-forge -c nvidia rapids=24.08 python=3.11 cuda-version=12.5
    ```

## Spark Rapids Jar

Download the latest Spark Rapids jar from [here](https://nvidia.github.io/spark-rapids/docs/download.html) and place it in `jars` folder.

