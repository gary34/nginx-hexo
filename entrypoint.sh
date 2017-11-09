#!/bin/bash
set -x

[ -z $HOST ] && HOST=$(hostname -i)
sed -i "s/IP_OR_HOST/$HOST/" /etc/nginx/conf.d/hexo.conf
pm2 start webhook.js --name webhook

[ ! -d "/app/hexo/public" ] \
	&& git clone $GITREPO /app/hexo/ \
	&& cd /app/hexo \
	&& npm install 
hexo g
nginx -g 'daemon off;'