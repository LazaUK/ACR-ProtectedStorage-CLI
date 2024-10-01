#
# Demo image by Laziz Turakulov, October 2024
#

FROM nginx:latest

COPY demopage.tar.gz /tmp/

RUN tar -xzvf /tmp/demopage.tar.gz -C /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]