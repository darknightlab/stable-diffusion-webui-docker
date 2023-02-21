#!/usr/bin/env bash
source "${venv_dir}"/bin/activate
# install xformers and pytorch
pip install --pre xformers
pip install --pre torchvision
pip install triton