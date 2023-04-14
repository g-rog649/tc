FROM ubuntu:latest as build
ARG NODE_VERSION=v18.16.0
RUN apt update && apt install -y wget xz-utils
RUN wget https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.xz
RUN mkdir -p /usr/local/lib/nodejs
RUN tar -xJvf node-${NODE_VERSION}-linux-x64.tar.xz -C /usr/local/lib/nodejs
RUN exec echo "export PATH=/usr/local/lib/nodejs/node-${NODE_VERSION}-linux-x64/bin:\$PATH" >> ~/.profile
WORKDIR /app
COPY ./app /app
RUN . ~/.profile && npm install
CMD . ~/.profile && npm start

FROM nginx:latest
COPY ./nginx.conf /etc/nginx/conf.d/
COPY --from=build /app /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]
EXPOSE 80
