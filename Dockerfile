FROM golang:1.20 as builder
ENV GO111MODULE=on
ENV GOPROXY=http://goproxy.cn
WORKDIR /app
COPY go.mod ./
RUN go mod download
COPY . ./
RUN go build -o webapp1 -ldflags '-s -w' ./main.go
FROM pingcap/alpine-glibc:alpine-3.14.6-gcompat
RUN apk add --no-cache tzdata
ENV TZ="Asia/Shanghai"
COPY --from=builder /app/webapp1 .
CMD ["/bin/sh", "-c", "./webapp1"]
