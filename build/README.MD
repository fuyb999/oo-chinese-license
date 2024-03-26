# ONLYOFFICE build

## build www
```shell
git clone -b v8.0.1 --recursive https://github.com/ONLYOFFICE/DocumentServer.git

sudo docker build -t oo-offline-build .

sudo docker run --rm -v $(pwd)/DocumentServer:/opt/app \
  -e "BUILD_VERSION=8.0.1" \
  -e "BUILD_NUMBER=31" \
  oo-offline-build:latest 
```
run
```shell
sudo docker run -i -t -d --network=host --name onlyoffice --restart=always \
-v /app/onlyoffice/DocumentServer/logs:/var/log/onlyoffice \
-v /app/onlyoffice/DocumentServer/data:/var/www/onlyoffice/Data \
-v /app/onlyoffice/DocumentServer/lib:/var/lib/onlyoffice \
-v /app/onlyoffice/DocumentServer/rabbitmq:/var/lib/rabbitmq \
-v /app/onlyoffice/DocumentServer/redis:/var/lib/redis \
-v /app/onlyoffice/DocumentServer/db:/var/lib/postgresql \
-v $(pwd)/DocumentServer/sdkjs/deploy/sdkjs:/var/www/onlyoffice/documentserver/sdkjs \
-v $(pwd)/DocumentServer/web-apps/deploy/web-apps:/var/www/onlyoffice/documentserver/web-apps \
fuyb/onlyoffice-unlimit:8.0.1.1
```

## clean deploy
```shell
sudo rm -rf DocumentServer/web-apps/build/node_modules \
    && sudo rm -rf DocumentServer/web-apps/build/plugins/grunt-inline/node_modules \
    && sudo rm -rf DocumentServer/web-apps/build/sprites/node_modules \
    && sudo rm -rf DocumentServer/web-apps/deploy \
    && sudo rm -rf DocumentServer/sdkjs/build/node_modules \
    && sudo rm -rf DocumentServer/sdkjs/build/deserializer/node_modules \
    && sudo rm -rf DocumentServer/sdkjs/deploy
```