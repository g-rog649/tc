FROM nginx
WORKDIR /etc/nginx
COPY ./default.conf ./conf.d/
COPY ./includes ./includes
COPY ./certs ./certs
RUN mkdir -p /data/nginx/cache
CMD ["nginx", "-g", "daemon off;"]
EXPOSE 443
