FROM golang:1.24 AS build
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o server

FROM scratch AS prod
WORKDIR /app
COPY --from=build /app/server .
ENTRYPOINT [ "./server" ]
