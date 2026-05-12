
target ?= level5
container ?= shell
COMPOSE = docker compose -f examples/$(target)/docker-compose.yml

.PHONY: build build-fpm run-fpm up down exec

## php-fpm 이미지 빌드 (php-fpm/Dockerfile)
build-fpm:
	docker build -t php:8.4.7-fpm ./php-fpm

## 두 이미지 모두 빌드
build: build-fpm

## php-fpm 컨테이너 단독 실행 (디버깅용)
run-fpm:
	docker run -it --rm -e USE_ZEND_DTRACE=1 php:8.4.7-fpm /bin/bash

## docker compose 기동 (php-fpm + nginx + bpftrace)
up:
	$(COMPOSE) up -d --build

## docker compose 종료
down:
	$(COMPOSE) down

## 레벨에 맞는 컨테이너 접속
exec:
	$(COMPOSE) exec $(container) bash