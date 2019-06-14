FROM alpine:edge AS builder
WORKDIR /app

RUN apk --update --no-cache add hugo
COPY . /app
RUN hugo

FROM nginx:alpine

COPY .docker/default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/public /usr/share/nginx/html