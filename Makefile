
.PHONY: build build-fpm build-bpftrace run-fpm up down exec-bpftrace

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
	docker compose up -d --build

## docker compose 종료
down:
	docker compose down

## bpftrace 컨테이너에 bash 접속
exec-bpftrace:
	docker compose exec bpftrace bash
