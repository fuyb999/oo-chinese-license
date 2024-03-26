#!/bin/bash

if [ -d "/opt/app/web-apps" ]; then
   if [ ! -d "/opt/app/web-apps/build/node_modules" ]; then
     rm -rf /opt/app/web-apps/build/*
     cp -r /opt/build/web-apps/* /opt/app/web-apps/build/
   fi
   # 注意如果是 sh sprites.sh 找不到 pushd命令
  cd /opt/app/web-apps/build && bash sprites.sh && grunt
fi

if [ -d "/opt/app/sdkjs" ]; then
 if [ ! -d "/opt/app/sdkjs/build/node_modules" ]; then
   rm -rf /opt/app/sdkjs/build/*
   cp -r /opt/build/sdkjs/* /opt/app/sdkjs/build/
 fi
 cd /opt/app/sdkjs/build && grunt
 cd ../ && make
fi