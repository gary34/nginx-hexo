# Nginx-Hexo

Nginx 做前端代理，使用node server监听Github的webhook。只要Github有push便会拉取最新代码并生成hexo页面。

## 如何使用

```

docker run --name hexo \
-v /tmp/hexo:/app/hexo \
-p 80:80 \
-e HOST=#{Your domain} \
-e GITREPO=#{Your github repo} \
-d nginx-hexo
```

