import { kafka } from "./config/kafka.js";

export const producer = kafka.producer();

async function producerMessage() {
  await producer.connect();
  await producer.send({
    topic: "teste",
    messages: [{ value: "Hello KafkaJS user!" }],
  });

  await producer.disconnect();
}

producerMessage();
