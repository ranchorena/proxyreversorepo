# docker build -t proxy-reverso-nginx . 
# docker run -p 80:80 -d proxy-reverso-nginx 

# docker build -t proxy-reverso-nginx:qa --no-cache /usr/src/app/proxyreverso
# docker run -d --restart=always -p 80:80 --name proxy-reverso-nginx proxy-reverso-nginx:qa
