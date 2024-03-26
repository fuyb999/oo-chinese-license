# 镜像来源
FROM xbeeant/oo-unlimit:8.0.1.1

ENV TZ=Asia/Shanghai
ENV JWT_ENABLED=false

RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
RUN apt-get update \
    && apt-get install -y jq

# 移除一些插件
# find /var/www/onlyoffice/documentserver/sdkjs-plugins -name "config.json" -type f -exec sh -c "jq -r '.name, .guid' {} | sed -e 's/^asc.//' | tr '\n' ' '; echo ''" \;
ADD delete-sdkjs-plugins.sh .
RUN chmod +x delete-sdkjs-plugins.sh \
    && sh delete-sdkjs-plugins.sh \
    && rm -rf delete-sdkjs-plugins.sh

# 移除字体
WORKDIR /usr/share/fonts/
RUN rm -rf *
WORKDIR /var/www/onlyoffice/documentserver/core-fonts/
RUN rm -rf *

# 导入中文字体
ADD ["onlyoffice-chinese-fonts/mini_fonts/*", "/usr/share/fonts/truetype/custom/fonts/"] 

# 添加一些插件
ADD sdkjs-plugins/sdkjs-plugins/content/html /var/www/onlyoffice/documentserver/sdkjs-plugins/html
ADD sdkjs-plugins/sdkjs-plugins/content/autocomplete /var/www/onlyoffice/documentserver/sdkjs-plugins/autocomplete
ADD sdkjs-plugins/sdkjs-plugins/content/doc2md /var/www/onlyoffice/documentserver/sdkjs-plugins/doc2md
ADD sdkjs-plugins/sdkjs-plugins/content/wordscounter /var/www/onlyoffice/documentserver/sdkjs-plugins/wordscounter

# 修正 plugin.[css|js] 引用问题
RUN find /var/www/onlyoffice/documentserver/sdkjs-plugins -name "*.html" -type f -exec sed -i 's|https://onlyoffice.github.io/sdkjs-plugins/|../|g' {} \;

# 修正hightlight js引用问题（新版没有该问题）
# RUN sed -i "s/https:\/\/ajax.googleapis.com\/ajax\/libs\/jquery\/2.2.2\/jquery.min.js/vendor\/jQuery-2.2.2-min\/jquery-v2.2.2-min.js/" /var/www/onlyoffice/documentserver/sdkjs-plugins/highlightcode/index.html

# 修改文件缓存时间
# 修改24小时为1小时
# RUN sed -i  "s/86400/3600/" /etc/onlyoffice/documentserver/default.json

# 允许私有ip访问
RUN sed -i 's/"allowPrivateIPAddress": false/"allowPrivateIPAddress": true/g' /etc/onlyoffice/documentserver/default.json
RUN sed -i 's/"allowMetaIPAddress": false/"allowMetaIPAddress": true/g' /etc/onlyoffice/documentserver/default.json

# 修改文件大小为500M
RUN sed -i "s/104857600/524288000/" /etc/onlyoffice/documentserver/default.json

EXPOSE 80 443

ARG COMPANY_NAME=onlyoffice
VOLUME /var/log/$COMPANY_NAME /var/lib/$COMPANY_NAME /var/www/$COMPANY_NAME/Data /var/lib/postgresql /var/lib/rabbitmq /var/lib/redis /usr/share/fonts/truetype/custom

RUN rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/app/ds/run-document-server.sh"]
