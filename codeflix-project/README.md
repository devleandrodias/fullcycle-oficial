# CodeFlix

# O que vai ter no projeto?

- Uma espécie de Netflix
- Assinatura do serviço pelos clientes
- Catálogo de vídeos para navegação
- Playback de vídeos
- Busca full text no catálogo
- Processamento e encoding dos vídeos
- Administração do catálogo de vídeos
- Administração dos serviços de assinatura
- Autenticação

# Decisões de projetos e de arquitetura (Microserviços)

- Arquitetura baseada em microserviços
- Tecnologia adequada para cada contexto (Ex: Go para processar vídeos)
- Não existe uma única verdade na escolha das tecnologias
- Microserviços podem ser substituídos por outros com tecnologias diferentes
- Cada microserviço terá seu próprio processo de CI/CD

# Decisões de projeto e de arquitetura (Escala Horizontal)

- O processo de escala poderá ser configurado a nível de microserviço
- Todos os microserviços trabalharão de forma stateless
- Quando utilizado upload de qualquer tipo de asset, o mesmo será armazenado em um cloud storage
- O processo de escala se dará no aumento na quantidade de PODs do Kubernetes
- O processo de autoscaling também será utilizado através de um recurso chamado HPA (Horizontal Pod Autoscaler)

# Decisões de projetos e de arquitetura (Service Discovery)

- Não haverá a necessidade de trabalhar com um sistema de Service Discovery como "Consul"
- O projeto utilizará o Kubernetes para orquestrar os containers, logo o Service Discovery já faz parte do processo

# Decisões de projetos e de arquitetura (Consistência eventual)

- Grande parte da comunicação entre os microserviços será assíncrona
- Cada microserviço possuirá sua própria base de dados
- Eventualmente, os dados poderão ficar inconsistentes, desde que não haja prejuízo direto ao negócio

# Decisões de projetos e de arquitetura (Duplicação de dados)

- Eventualmente, um microserviço poderá persistir dados já existentes em outro microserviço em seu banco de dados
- Essa duplicação ocorre para deixar o microserviço mais autônomo e preciso
- O microserviço duplicará apenas os dados necessários para seu contexto
- No caso da CodeFlix, utilizaremos o Kafka Connect como replicador de dados

# Decisões de projetos e de arquitetura (Mensageria)

- Como parte da comunicação entre os microserviços é assíncrona, um sistema de mensageria é necessário
- O RabbitMQ foi escolhido para esse caso
- Por que não o Apache Kafka ou Amazon SQS, entre outros?
- Apache Kafka também poderia ser utilizado nesse caso, por outro lado
- Decidimos utilizar o Kafka juntamente com o Kafka Connect apenas para replicação de dados
- Evitaremos ao máximo o lock-in nos cloud providers, logo, Amazon SQS e similares foram descartados
- Não há uma verdade única sobre a escolha realizada

# Decisões de projetos e de arquitetura (Resiliência e Self-Healing)

- Para garantir resiliência caso um ou mais microserviços fiquem fora do ar, as filas serão essenciais
- Caso uma mensagem venha em um padrão não esperado para determinado microserviço, o microserviço poderá rejeitá-la e automaticamente a mesma poderá ser encaminhada para uma dead-letter queue
- Pelo fato de o Kubernetes e Istio possuírem recursos de Circuit Breaker e Liveness e Readiness probes
- Se um container tiver um crash, automaticamente ele será reiniciado ou mesmo recriado
- Caso um container não aguente determinado tráfego, temos a opção de trabalhar com Circuit Breakers
- Impedir que o microserviço receba mais requisições enquanto está se "curando"

# Decisões de projetos e de arquitetura (Autenticação)

- Serviço centralizado de identidade open-source: Keycloak
- OpenID Connect
- Customização do tema
- Utilização do create-react-app
- Compartilhamento de chave pública com os serviços para verificação de autenticidade dos tokens
- Diversos tipos de ACL
- Flows de autenticação para frontend e backend

# Decisões de projetos e de arquitetura (Microserviços do Sistema)

- Backend admin do catálogo de vídeos
- Frontend admin do catálogo de vídeos
- Encoder de vídeo
- Backend API do catálogo
- Frontend do catálogo
- Assinatura do CodeFlix pelo cliente
- Autenticação entre microserviços com Keycloak
- Comunicação assíncrona entre os microserviços com RabbitMQ
- Replicação de dados utilizando Apache Kafka e Kafka Connect

# Decisões de projetos e de arquitetura (Ambiente de Desenvolvimento)

- Docker é protagonista do ambiente de desenvolvimento
- Permite a rápida criação do ambiente
- Garante que os ambientes serão exatamente os mesmos
- Facilita a criação de recursos periféricos como banco de dados, RabbitMQ, etc.
- Geração de imagens para o ambiente de produção
- Para cada pull request gerada em uma aplicação, iniciaremos o processo de CI
- GitHub Actions
- O processo de CI será capaz de:
  - Subir uma aplicação usando Docker
  - Executar os testes
  - Utilizar o SonarQube
- No caso de acontecer o "merge" da Pull Request, o processo de CD acontece:
  - Fará a geração da imagem Docker
  - Realizará o upload da imagem em uma container registry
  - Executará o deploy no Kubernetes
- Cluster Kubernetes gerenciado
- Startup, Readiness e Liveness probe para self-healing
- Horizontal Pod Autoscaler
- IaC (Infrastructure as Code) - Terraform e Ansible
- Providers AWS, GCP e Azure
