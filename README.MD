# ONLYOFFICE 中文包 授权（你懂的）镜像构建脚本

* 基础镜像来源于`alehoho/oo-ce-docker-license`
* 引用了 `https://github.com/funggtopp/onlyoffice-chinese-fonts.git` 工程，解决中文字库问题
* 添加了 `wordscounter`,`doc2md`,`autocomplete`,`highlightcode`, `html` 插件
* 去除了 `youtube`,`translator`,`zotero`,`mendeley`,`thesaurus`,`ocr` 国内无法使用的插件
* ~~解决了 `hightligh`插件 引用google的jquery.min.js问题~~
* 解决了 插件`index.html`中 plugin.[css|js] 引用
* 解决了 允许私有ip访问

## clone
```shell
git clone --recursive https://github.com/fuyb999/oo-chinese-license.git
```

## build
```shell
sudo docker build -t fuyb/onlyoffice-unlimit:8.0.1.1 .
```

## run
```shell
sudo docker run -i -t -d --network=host --name onlyoffice --restart=always \
-v /app/onlyoffice/DocumentServer/logs:/var/log/onlyoffice \
-v /app/onlyoffice/DocumentServer/data:/var/www/onlyoffice/Data \
-v /app/onlyoffice/DocumentServer/lib:/var/lib/onlyoffice \
-v /app/onlyoffice/DocumentServer/rabbitmq:/var/lib/rabbitmq \
-v /app/onlyoffice/DocumentServer/redis:/var/lib/redis \
-v /app/onlyoffice/DocumentServer/db:/var/lib/postgresql \
fuyb/onlyoffice-unlimit:8.0.1.1
```