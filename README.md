<h1 align="center">Gin Web Docker</h1>

<div align="center">
Docker Compose一键部署Gin Web, 解决构建部署烦恼
</div>

## 快速开始

### 命令行
```
git clone git@github.com:piupuer/gin-web-docker.git

# 注意: 
# 前后端项目指定了阿里云镜像, 如果在本地构建, 需要将前后端项目clone到根目录下
├── gin-web-docker # 部署构建根目录
│   ├── gin-web # 后端项目
│   │   └─── Dockerfile # docker镜像构建配置
│   ├── gin-web-vue # 前端项目
│   │   └─── Dockerfile # docker镜像构建配置
│   ├── docker-compose.yml # docker compose部署配置文件
│   ├── .gitignore # git忽略文件列表
│   ├── .dockerignore # docker忽略文件列表
│   └── README.md # 说明文档
# cd gin-web-docker
# git clone git@github.com:piupuer/gin-web
# git clone git@github.com:piupuer/gin-web-vue
# 注释掉image, 打开build
# vim docker-compose.web.yml
# vim docker-compose.ui.yml

# 开始构建
cd gin-web-docker
docker-compose -f docker-compose.db.yml -f docker-compose.web.yml -f docker-compose.ui.yml build
# 无缓存构建
# docker-compose -f docker-compose.db.yml -f docker-compose.web.yml -f docker-compose.ui.yml build --no-cache
# 运行(后台启动)
docker-compose -f docker-compose.db.yml -f docker-compose.web.yml -f docker-compose.ui.yml up -d
```
### shell脚本(支持unix内核系统)

```
git clone git@github.com:piupuer/gin-web-docker.git
cd gin-web-docker
chmod +x control.sh
# 指定远程镜像版本
export WEB_TAG=xxx
export UI_TAG=xxx
# 运行必须组件(第二次就不用再执行)
./control.sh init
# 运行前后端
./control.sh run gin-web-prod
./control.sh run gin-web-vue-prod
```

### nginx配置

请将docker-conf/nginx目录下的配置文件拷贝到nginx安装目录(Ubuntu是在/etc/nginx)

### 域名映射

由于nginx.conf中设置了域名piupuer-local.com(也可以改成你自己的域名), 需要修改hosts才能访问, 部署机器ip为192.168.1.105

```
sudo vim /etc/hosts

# 在/etc/hosts文件中添加一行
192.168.1.105 piupuer-local.com
```

> docker-compose运行成功后, 可在浏览器中输入: [http://piupuer-local.com:10001](http://piupuer-local.com:10001), 若不能访问请检查nginx/docker-compose配置是否正确


## Ubuntu 18.04安装docker
```shell
# docker
apt-get update
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
curl -fsSL http://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository \
   "deb [arch=amd64] http://mirrors.aliyun.com/docker-ce/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
apt-get update
apt-get install docker-ce

# docker-compose
curl -L https://github.com/docker/compose/releases/download/1.26.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
```


## 互动交流

### QQ群：943724601

<img src="https://github.com/piupuer/gin-web/blob/contact/images/qq.jpeg?raw=true" width="256" alt="QQ群" />

## MIT License

    Copyright (c) 2020 piupuer
