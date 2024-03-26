# ONLYOFFICE build

## build www
```shell
git clone -b v8.0.1 --recursive https://github.com/ONLYOFFICE/DocumentServer.git
sudo docker build -t oo-offline-build .

sudo docker run -v $(pwd)/DocumentServer:/opt/app oo-offline-build:latest 
```