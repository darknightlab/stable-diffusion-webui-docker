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
COPY webui.sh /home/diffusion/webui.sh
RUN chown diffusion:diffusion /home/diffusion/webui.sh

# install stable-diffusion-webui
USER diffusion
RUN cd /home/diffusion/ \
    && chmod +x webui.sh && bash webui.sh --use-cpu all --skip-torch-cuda-test && rm webui.sh \
    && rm -rf /home/diffusion/.cache

# install xformers
USER root
RUN cd /home/diffusion/stable-diffusion-webui/ \
    && apt update && apt install -y g++ \
    && su diffusion && . /home/diffusion/stable-diffusion-webui/venv/bin/activate \
    && pip install xformers==0.0.12 \
    && deactivate && exit \
    && apt remove -y g++ && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# config
USER diffusion
WORKDIR /home/diffusion/stable-diffusion-webui/
RUN mkdir config && touch config/config.json config/ui-config.json config/style.csv && \
    ln -s /home/diffusion/stable-diffusion-webui/config/config.json config.json && \
    ln -s /home/diffusion/stable-diffusion-webui/config/ui-config.json ui-config.json && \
    ln -s /home/diffusion/stable-diffusion-webui/config/style.csv style.csv

ENTRYPOINT [ "logsave","/home/diffusion/stable-diffusion-webui/log/log.txt", "/home/diffusion/stable-diffusion-webui/venv/bin/python", "launch.py" ]
CMD []