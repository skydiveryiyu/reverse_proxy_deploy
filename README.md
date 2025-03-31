# 腾讯云轻量服务器反向代理自动化部署方案

本项目提供了一个基于 CentOS 7.8 和 Docker 的反向代理自动化部署方案。

## 环境要求

- CentOS 7.8
- Docker 20.10+
- Docker Compose 2.0+

## 目录结构

```
.
├── docker-compose.yml    # Docker Compose 配置文件
├── nginx/               # Nginx 配置目录
│   ├── conf.d/         # Nginx 站点配置
│   └── nginx.conf      # Nginx 主配置文件
├── scripts/            # 部署脚本
│   └── deploy.sh      # 自动化部署脚本
└── README.md          # 项目说明文档
```

## 快速开始

1. 克隆项目到服务器：
```bash
git clone [项目地址]
cd reverse_proxy_deploy
```

2. 运行部署脚本：
```bash
bash scripts/deploy.sh
```

3. 配置反向代理：
编辑 `nginx/conf.d/default.conf` 文件，添加您的反向代理配置。

4. 重启服务：
```bash
docker-compose restart nginx
```

## 配置说明

### Nginx 配置

Nginx 配置文件位于 `nginx/conf.d/` 目录下，您可以根据需要修改或添加新的配置文件。

### Docker 配置

Docker 相关配置在 `docker-compose.yml` 文件中，包括：
- 容器名称
- 端口映射
- 数据卷挂载
- 网络设置

## 维护说明

- 查看服务状态：`docker-compose ps`
- 查看服务日志：`docker-compose logs -f nginx`
- 重启服务：`docker-compose restart nginx`
- 停止服务：`docker-compose down` 