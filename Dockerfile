FROM alpine
LABEL maintainer="acend"
RUN apk --no-cache add thttpd 
COPY index.html /var/www/
EXPOSE 80
ENTRYPOINT ["/usr/sbin/thttpd", "-D", "-r", "-d", "/var/www/"]
