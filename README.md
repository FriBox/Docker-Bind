# Docker-Bind
dockerfile for Bind （Bind and Webmin 的 Docker 镜像编译文件）

Web Page Url（Bind 官方页面）:<br>
　　[https://www.isc.org/bind](https://www.isc.org/bind)<br>

## Building the image （编译镜像）
```
git clone https://github.com/FriBox/Docker-Bind.git
cd Docker-Bind
docker build -t fribox/bind .
```

## Export the image （导出镜像保存）
```
docker save fribox/bind -o FriBox.Docker-Bind.tar
```

## Import the image （手动导入镜像）
```
docker load -i FriBox.Docker-Bind.tar
```

## Running the container (启动容器)
```
docker run --name Bind-Service -d --restart=always --env ROOT_PASSWORD="PassWord" --publish 53:53/tcp --publish 53:53/udp --publish 10000:10000/tcp fribox/bind
```

## Log into management page （登录页面Web管理页面）
```
https://hostname.or.ip:10000
(root:pass) 用户名和密码
```
