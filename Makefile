
target ?= level5
COMPOSE = docker compose -f examples/$(target)/docker-compose.yml

.PHONY: build build-fpm build-bpftrace run-fpm up down exec-bpftrace trace

## php-fpm 이미지 빌드 (php-fpm/Dockerfile)
build-fpm:
	docker build -t php:8.4.7-fpm ./php-fpm

## bpftrace 이미지 빌드 (bpftrace/Dockerfile)
build-bpftrace:
	docker build -t php-bpftrace:latest ./bpftrace

## 두 이미지 모두 빌드
build: build-fpm build-bpftrace

## php-fpm 컨테이너 단독 실행 (디버깅용)
run-fpm:
	docker run -it --rm -e USE_ZEND_DTRACE=1 php:8.4.7-fpm /bin/bash

## docker compose 기동 (php-fpm + nginx + bpftrace)
up:
	$(COMPOSE) up -d --build

## docker compose 종료
down:
	$(COMPOSE) down

## bpftrace 컨테이너에 bash 접속
exec-bpftrace:
	$(COMPOSE) exec bpftrace bash

## bpftrace 스크립트 실행 (예: make trace SCRIPT=request.bt)
trace:
	$(COMPOSE) exec bpftrace bash /scripts/run.sh /scripts/$(SCRIPT)
