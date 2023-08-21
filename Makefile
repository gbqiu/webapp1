all: build push

build:
	docker build -t qiuguobin/webapp1 .
push:
	docker push qiuguobin/webapp1