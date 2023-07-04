package main

import (
	"fmt"
	"log"

	"github.com/confluentinc/confluent-kafka-go/kafka"
)

func main() {
	producer := NewKafkaProducer()
	deliveryChan := make(chan kafka.Event)

	Publish("transaferiu", "teste", producer, []byte("transaferencia"), deliveryChan)
	go DeliveryReport(deliveryChan)
	producer.Flush(1000)
}

func NewKafkaProducer() *kafka.Producer {
	configMap := &kafka.ConfigMap {
		"bootstrap.servers": "kafka:9092",
		"delivery.timeout.ms": "0",
		// "acks": "all",
		// "enable.idempotence": "true",
	}

	p, err := kafka.NewProducer(configMap)

	if err != nil {
		log.Println(err.Error())
	}

	return p
}

func Publish(msg string, topic string, producer *kafka.Producer, key []byte, deliveryChan chan kafka.Event) error {
	message := &kafka.Message {
		Key: key,
		Value: []byte(msg),
		TopicPartition: kafka.TopicPartition{ Topic: &topic, Partition: kafka.PartitionAny },
	}

	err := producer.Produce(message, deliveryChan)

	if err != nil {
		return err
	}

	return nil
}

func DeliveryReport(deliveryChan chan kafka.Event) {
	for e := range deliveryChan {
		switch ev := e.(type) {
		case *kafka.Message:
			if ev.TopicPartition.Error != nil {
				fmt.Println("Erro ao enviar")
			} else {
				fmt.Println("Mensagem enviada: ", ev.TopicPartition)
				// Anotar no banco de dados que a mensagem foi processada
				// Ex: Confirma que uma transferência bancária ocorreu
			}	
		}
	}
}