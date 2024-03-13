#!/bin/bash

# 使用 find 命令查找特定的插件目录并删除它们
plugins=$(find /var/www/onlyoffice/documentserver/sdkjs-plugins -name "config.json" -exec sh -c 'jq -r ".name" {} | grep -E "YouTube|Zotero|OCR|Mendeley|Translator|Thesaurus" && dirname {}' \;)

# 循环遍历插件目录并删除它们
for plugin in $plugins; do
    echo "$plugin"
    rm -rf "$plugin"
done