FROM golang:1.13
COPY main.go /go
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build 

FROM alpine
LABEL maintainer="acend"
RUN mkdir -p /opt/www/static
COPY --from=0 /go/go /opt/www/
COPY index.html /opt/www/static/ 
COPY check.sh /opt/www/static/ 
RUN adduser -D web

EXPOSE 5000
USER web
CMD [ "/opt/www/go" ]
