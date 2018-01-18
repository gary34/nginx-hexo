FROM alpine
LABEL maintainer="Gary"


RUN apk add --no-cache \
	nginx \
	git \
	ca-certificates \
	nodejs \
	jq \
	curl \
	&& rm -f /etc/nginx/conf.d/default.conf \
	&& mkdir -p /run/nginx \
	&& myip=$(curl -s ifconfig.me);  \
	echo "myip ${myip}"; \
	country_code=$(curl -s http://freegeoip.net/json/${myip}|jq .country_code); \
	if [ "${country_code}" = "CN" ]; then \
		npm config set registry https://registry.npm.taobao.org; \
	fi; \
	npm install -g hexo-cli pm2

COPY webhook.js /app/
COPY entrypoint.sh /
COPY hexo.conf /etc/nginx/conf.d
WORKDIR /app
ENTRYPOINT ["/entrypoint.sh"]
EXPOSE 80
