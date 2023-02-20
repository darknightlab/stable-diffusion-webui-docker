FROM ubuntu:latest
# nvidia environment
ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=all

# install dependencies
RUN apt update && apt install -y \
    git \
    wget \
    python3 \
    python3-venv \
    libgl1 \
    libglib2.0-0 \
    libsm6 \
    libxrender1 \
    libxext6 \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd -r diffusion && useradd -r -g diffusion diffusion && mkdir -p /home/diffusion && chown -R diffusion:diffusion /home/diffusion
COPY webui.sh custom_install.sh /home/diffusion/
RUN chown diffusion:diffusion /home/diffusion/webui.sh

# install stable-diffusion-webui
USER diffusion
RUN cd /home/diffusion/ \
    && chmod +x webui.sh && bash webui.sh --use-cpu all --skip-torch-cuda-test \
    && rm webui.sh custom_install.sh \
    && rm -rf /home/diffusion/.cache \
    # 原版webui.sh, 前面的webui.sh是为了预安装
    && wget https://raw.githubusercontent.com/AUTOMATIC1111/stable-diffusion-webui/master/webui.sh

# config
USER diffusion
WORKDIR /home/diffusion/stable-diffusion-webui/
RUN mkdir config && touch config/config.json config/ui-config.json config/style.csv && \
    ln -s /home/diffusion/stable-diffusion-webui/config/config.json config.json && \
    ln -s /home/diffusion/stable-diffusion-webui/config/ui-config.json ui-config.json && \
    ln -s /home/diffusion/stable-diffusion-webui/config/style.csv style.csv

ENTRYPOINT [ "/home/diffusion/stable-diffusion-webui/venv/bin/python", "launch.py" ]
CMD []
