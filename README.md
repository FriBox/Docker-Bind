# Docker-Bind
dockerfile for bind （Bind 的 Docker 镜像编译文件）

Bind Url（Bind 官方页面）:<br>
　　[https://www.isc.org/bind/](https://www.isc.org/bind/)<br>

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

## Running the container (启动容器)
```
docker run -d -p 10000:10000 fribox/bind
```

## Log into webmin-bind and manage your server （登录页面Webmin管理页面进行Bind管理）
```
https://hostname.or.ip:10000
(root:pass) 用户名和密码
```
