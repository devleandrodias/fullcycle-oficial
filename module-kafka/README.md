# How execute kafka?

## View docker container

> docker-compose up -d

> docker container ls

> docker logs kafka

> docker exec -it kafka bash

## Create a topic

> kafka-topics --bootstrap-server=localhost:9092 --create --topic=teste --partitions=3

> kafka-topics --bootstrap-server=localhost:9092 --list

> kafka-topics --bootstrap-server=localhost:9092 --describe --topic=teste

> kafka-console-consumer --bootstrap-server=localhost:9092 --topic=teste --from-beginning

> kafka-console-consumer --bootstrap-server=localhost:9092 --topic=teste --group=x

> kafka-console-producer --bootstrap-server=localhost:9092 --topic=teste

> kafka-consumer-groups --bootstrap-server=localhost:9092 --group=x --describe
