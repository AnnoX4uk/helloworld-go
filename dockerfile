FROM golang:1.16-alpine as base
FROM base as builder-stage1
RUN mkdir /install
WORKDIR /install
ADD helloworld.go /install/
ADD go.mod /install/
ADD go.sum /install/
RUN go build helloworld.go
FROM alpine:3.14 as base
RUN mkdir /app
COPY --from=builder-stage1 /install/helloworld /app
WORKDIR /app
EXPOSE 8080
CMD ["/app/helloworld"]
