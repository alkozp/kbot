APP=$(shell basename $(shell git remote get-url origin))
#REGISTRY=ghcr.io/alkozp
REGISTRY=alkozp
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETOS=linux
TARGETARCH=amd64


format:
	gofmt -s -w ./

lint:
	golint

test:
	go test -v

get:
	go get

linux:
	@TARGETOS=linux
	@TARGETARCH=amd64
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/alkozp/kbot/cmd.appVersion=${VERSION}
darwin:
	@TARGETOS=darwin
	@TARGETARCH=amd64
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/alkozp/kbot/cmd.appVersion=${VERSION}
darwin_arm64:
	@TARGETOS=darwin
	@TARGETARCH=arm64
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/alkozp/kbot/cmd.appVersion=${VERSION}
windows:
	@TARGETOS=windows
	@TARGETARCH=amd64
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/alkozp/kbot/cmd.appVersion=${VERSION}

build: format
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/alkozp/kbot/cmd.appVersion=${VERSION}

image:
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETOS}-${TARGETARCH}

push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETOS}-${TARGETARCH}

clean:
	rm -rf kbot