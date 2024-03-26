#!/bin/bash

css_list=$(find /var/www/onlyoffice/documentserver/web-apps -name "*.css")

for css in $css_list
do
    echo "$css"
    echo '.logo,.loading-logo,#left-btn-about,#left-btn-support,#fm-btn-help,.loader-page-text-customer{display:none !important;} .loader-page-text{line-height: 80px !important;}' >> $css
done