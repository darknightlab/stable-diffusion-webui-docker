#!/usr/bin/env bash
source "${venv_dir}"/bin/activate
# install xformers and pytorch
pip install --pre xformers
pip install --pre torchvision
pip install triton
pip install transformers==4.19.2 # 因为本地网络不好，版本升上去下载不了文件
pip list |grep transformers # 测试版本