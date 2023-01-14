# stable-diffusion-webui-Docker

简单的做了一个 docker.

## 依赖

-   docker
-   [nvidia-container-toolkit](https://gitlab.com/nvidia/container-toolkit/container-toolkit/-/tree/main/cmd/nvidia-container-runtime)
-   显存>=4GB

## 安装

```bash
git clone https://github.com/darknightlab/stable-diffusion-webui-Docker
chmod -R 777 stable-diffusion-webui-Docker
cd stable-diffusion-webui-Docker
cp -r config-example/ config/
cp your-model.ckpt models/Stable-diffusion/
cd docker
# vim docker-compose.yml
docker compose up -d
```

过程中请保持互联网连接, 将会下载大约 3GB 内容. 编译时需要 nvidia-container-runtime, 可以根据 nvidia 教程修改 daemon.json
