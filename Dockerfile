FROM golang:1.13
COPY main.go /go
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build 

FROM alpine
LABEL maintainer="acend"
COPY --from=0 /go/go /usr/local/bin/
COPY index.html /
RUN adduser -D web

EXPOSE 5000
USER web
CMD [ "/usr/local/bin/go" ]



