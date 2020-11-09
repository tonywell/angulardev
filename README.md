# 用Docker打造angular开发环境

​        这里就不再赘述用Docker来打造前端代码环境的好处了，就记录一下如何基于Node官方Alpine版Docker镜像，来构建angular的开发环境，官方的镜像的Node版本为15.1，yarn版本为1.22.5版本。

​       为了支持node-sass增加了python3的安装，同时安装了git、zsh、vim等工具，安装sudo解决一些操作权限问题，能够开箱即用。

​       然后通过vsc的remote-containers插件连接容器的angular开发环境进行开发。

### Quick Start

#### 1、构建镜像

```
$ docker build -t tonywell/angulardev .
```

说明：因为镜像中没有设置用户密码，所以安装sudo之后，为了执行sudu不用输入密码，讲用户node添加到wheel，同时在/etc/sudoers文件末尾加上下面的内容

```
$ addgroup node wheel
$ echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
```

#### 2、启动容器

```
$ docker-compose up -d
```

说明：

* 需要安装docker-compose，自行安装

* 容器的时间设置为上海

  ```
  environment:
     TZ: Asia/Shanghai
  ```

* 为了使容器不退出，坐如下配置

  ```
  stdin_open: true
  tty: true
  privileged: true
  ```

#### 3、VSC连接容器

* 首先VSC需要安装Remote-Containers插件
* 在vscode中按F1，输入Remote-Containers: Open，按照提示选择 Open to running Container ……，VSC会自动识别出容器，选择正在运行的angulardev容器
* 接下来就可以通过VSC在angulardev容器中愉快的开发了。