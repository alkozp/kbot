FROM golang:1.19 as builder
WORKDIR /go/src/app
COPY . .
RUN make build


FROM scratch
WORKDIR /
COPY --from=builder /go/src/app/kbot .
COPY --from=alpine:latest /etc/ssl/serts/ca-certificates.crt /etc/ssl/serts/
ENTRYPOINT [ "./kbot" ]