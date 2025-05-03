# RabbitMQ 🐇📬

## O que é RabbitMQ?

RabbitMQ é um **Message Broker** altamente confiável e flexível, desenvolvido em **Erlang**. Ele atua como intermediador entre produtores e consumidores de mensagens, promovendo **desacoplamento entre serviços** e garantindo **alta performance** e **resiliência** em arquiteturas distribuídas.

- Suporta múltiplos protocolos: **AMQP**, **MQTT**, **STOMP** e **HTTP**
- Utilizado como padrão de mercado para mensageria
- Extremamente rápido e poderoso para sistemas com alta demanda de comunicação assíncrona

## Tipos de Exchange

- **Direct**: Roteamento exato baseado na routing key.
- **Fanout**: Roteamento em broadcast — envia a mensagem para todas as filas.
- **Topic**: Roteamento baseado em padrões (wildcards) nas routing keys.
- **Headers**: Roteamento baseado nos headers personalizados da mensagem.

## Queues (Filas)

- Modelo **FIFO** – First In, First Out
- **Propriedades importantes**:
  - `durable`: Persiste a fila após reinicialização do broker
  - `auto-delete`: Fila removida automaticamente após desconexão do último consumidor
  - `expiry`: Tempo máximo de inatividade (sem mensagens e sem consumidores)
  - `message TTL`: Tempo de vida de cada mensagem
  - `overflow`:
    - `drop-head`: Remove a mensagem mais antiga
    - `reject-publish`: Rejeita novas mensagens ao exceder o limite
  - `exclusive`: Fila exclusiva para o canal que a criou
  - `max-length` / `max-length-bytes`: Limita número de mensagens ou tamanho total em bytes

## Dead Letter Queues (DLQ)

- Utilizadas para tratar mensagens que **não puderam ser entregues** ou processadas corretamente
- Mensagens são enviadas para uma **Exchange alternativa** que as roteia para uma DLQ
- As mensagens podem ser posteriormente analisadas, reprocessadas ou descartadas

## Lazy Queues

- Armazenam mensagens **diretamente em disco** ao invés da memória
- Utilizadas em casos com milhões de mensagens na fila
- Melhoram uso de memória, mas requerem alto desempenho de **I/O de disco**
- Estratégia útil para liberar memória sem perder mensagens

## Confiabilidade e Garantias

Como garantir que mensagens **não serão perdidas** e **serão processadas corretamente**?

- Recursos disponíveis:
  - **Consumer Acknowledgement** (`ack`): Consumidor confirma o processamento da mensagem
  - **Publisher Confirm** (`confirm`): Broker confirma que recebeu e persistiu a mensagem
  - **Mensagens e filas duráveis**: Persistência em disco
  - **Retries + Dead Letter Queues**: Tentativas de reprocessamento e fallback

## Plataforma para Testes

- Acesse: [https://tryrabbitmq.com/](https://tryrabbitmq.com/) — playground para aprender e testar RabbitMQ com exemplos visuais e comandos práticos

---

**RabbitMQ é uma ferramenta essencial para arquiteturas modernas, microserviços, sistemas desacoplados e filas assíncronas.**
