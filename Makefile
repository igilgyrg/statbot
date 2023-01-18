export GO111MODULE=on

ifneq (,$(wildcard ./.env))
    include .env
    export
endif

BIN = bin/statbot

.PHONY: update
update: ## Обновление зависимостей
	go mod tidy
	go mod verify

build: update ${BIN}

${BIN}:
	CGO_ENABLED=0 GOOS=linux go build -ldflags '-d -s -w' -a -o $@ github.com/igilgyrg/statbot/$< && ./bin/stat

build-run: build
	./bin/statbot
