FROM nginx

LABEL maintainer="Gary"
ARG LOCALE="en"
COPY webhook.js /app/
COPY entrypoint.sh /
COPY hexo.conf /etc/nginx/conf.d
RUN set -x \
	&& if [ "$LOCALE" = "cn" ]; then \
		sed -i 's/deb.debian.org/mirrors.163.com/g' /etc/apt/sources.list; \
		sed -i 's/security.debian.org/mirrors.163.com\/debian-security\//g' /etc/apt/sources.list; \
	fi; \
	apt-get update \
	&& apt-get install --no-install-recommends --no-install-suggests -y curl \
		ca-certificates \
		xz-utils \
		git \
	&& if [ "$LOCALE" = "cn" ]; then \
		curl -SLO https://npm.taobao.org/mirrors/node/latest-v8.x/node-v8.9.1-linux-x64.tar.xz; \
	else \
		curl -SLO https://nodejs.org/dist/v8.9.1/node-v8.9.1-linux-x64.tar.xz; \
	fi; \
	tar -xJf node-v8.9.1-linux-x64.tar.xz -C /usr/local --strip-components=1 --no-same-owner \
	&& ln -s /usr/local/bin/node /usr/local/bin/nodejs \
	&& if [ "$LOCALE" = "cn" ]; then \
		npm config set registry https://registry.npm.taobao.org; \
	fi; \
	npm install -g hexo-cli pm2 \
	&& apt-get purge -y --auto-remove \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /app
ENTRYPOINT ["/entrypoint.sh"]
EXPOSE 80