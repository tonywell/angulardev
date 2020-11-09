FROM node:alpine3.12

MAINTAINER tonywell <tongwei1985@gmail.com>

RUN true \
    #设置apk服务加速器和设置中国时间
    && echo http://mirrors.aliyun.com/alpine/v3.12/main/ > /etc/apk/repositories \
    && echo http://mirrors.aliyun.com/alpine/v3.12/community/ >> /etc/apk/repositories \
	&& ln -sf /usr/share/zoneinfo/PRC /etc/localtime 
	
RUN	apk update && apk upgrade \
    #安装zsh git vim wget curl等工具
	&& apk add --no-cache zsh git vim curl make gcc g++ python3 sudo\
	&& rm -rf /tmp/* /etc/apk/cache/*

ENV SHELL /bin/zsh

RUN addgroup node wheel \
    && echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN true \
    ## 安装oh-my-zsh
	&& sudo wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true \
	#设置npm加速器
	&& npm config set registry https://registry.npm.taobao.org \
    && npm config set disturl https://npm.taobao.org/dist \
    && npm config set sass_binary_site https://npm.taobao.org/mirrors/node-sass \
    && npm config set electron_mirror https://npm.taobao.org/mirrors/electron \
    && npm config set puppeteer_download_host https://npm.taobao.org/mirrors \
    && npm config set chromedriver_cdnurl https://npm.taobao.org/mirrors/chromedriver \
    && npm config set operadriver_cdnurl https://npm.taobao.org/mirrors/operadriver \
	&& npm config set phantomjs_cdnurl https://npm.taobao.org/mirrors/phantomjs \
    && npm config set selenium_cdnurl https://npm.taobao.org/mirrors/selenium \
	#设置yarn加速器
	&& chmod a+x /usr/local/bin/yarn \
    && yarn config set registry https://registry.npm.taobao.org || true \
    ##安装ng-cli
	&& yarn add global @angular/cli \
    ##安装anywhere
	&& yarn add global anywhere \
    #配置ng-cli和anywhere的环境变量
	&& ln -s /node_modules/@angular/cli/bin/ng /bin/ng \
	&& ln -s /node_modules/anywhere/bin /bin/anywhere

RUN mkdir /home/node/workspace

WORKDIR  /home/node/workspace

VOLUME  /home/node/workspace

EXPOSE 8081

CMD ["zsh"]
