package main

import (
	"fmt"

	"github.com/confluentinc/confluent-kafka-go/kafka"
)

func main() {
	configMap := &kafka.ConfigMap {
		"bootstrap.servers": "kafka:9092",
		"client.id": "goapp-consumer-email",
		"group.id": "goapp-group",
		// "auto.offset.reset": "earliest",
	}

	c, err := kafka.NewConsumer(configMap)

	if err != nil {
		fmt.Println("error on start consumer", err.Error())
	}

	topics := []string{"teste"}
	c.SubscribeTopics(topics, nil)
	for {
		msg, err := c.ReadMessage(-1)

		if err == nil {
			fmt.Println(string(msg.Value), msg.TopicPartition)
		}
	}
}