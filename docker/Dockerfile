FROM ubuntu:latest
ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=all
RUN apt-get update && apt-get install -y \
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
USER diffusion
RUN cd /home/diffusion/ && wget https://raw.githubusercontent.com/AUTOMATIC1111/stable-diffusion-webui/master/webui.sh && sed -i '$ised -i '\''$d'\'' "${LAUNCH_SCRIPT}"' webui.sh && chmod +x webui.sh && bash webui.sh && rm webui.sh
WORKDIR /home/diffusion/stable-diffusion-webui/
RUN mkdir config && touch config/config.json config/ui-config.json && ln -s /home/diffusion/stable-diffusion-webui/config/config.json config.json && ln -s /home/diffusion/stable-diffusion-webui/config/ui-config.json ui-config.json
ENTRYPOINT [ "logsave","/home/diffusion/stable-diffusion-webui/logs/logs.txt", "/home/diffusion/stable-diffusion-webui/venv/bin/python", "webui.py" ]
CMD [ "--listen", "--port", "7860" ]