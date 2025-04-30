# 🌍 Terraform - Visão Geral

## O que é o Terraform?

**Terraform** é uma ferramenta **open-source de "Infraestrutura como Código" (IaC)** criada pela HashiCorp. Com ela, você pode **provisionar e gerenciar recursos de infraestrutura** (servidores, redes, bancos de dados, DNS, etc.) em provedores de nuvem como AWS, GCP, Azure, e até soluções on-premise, de forma **automática, versionada e reprodutível**.

---

## 🧠 Como o Terraform funciona?

O Terraform utiliza **arquivos de configuração declarativos** escritos na linguagem **HCL (HashiCorp Configuration Language)**. Esses arquivos descrevem o **estado desejado da infraestrutura**, e o Terraform aplica as mudanças necessárias para que o ambiente reflita esse estado.

### Ciclo de vida básico:

1. **Escrever** os arquivos `.tf` com a infraestrutura desejada.
2. **Init** para inicializar o projeto.
3. **Plan** para visualizar o que será alterado.
4. **Apply** para aplicar as mudanças.
5. **Destroy** para destruir os recursos criados.

---

## 🔧 Principais comandos do Terraform

| Comando                           | Descrição                                                            |
| --------------------------------- | -------------------------------------------------------------------- |
| `terraform init`                  | Inicializa o projeto (baixa os providers, configura o backend, etc.) |
| `terraform validate`              | Valida a sintaxe dos arquivos `.tf`                                  |
| `terraform fmt`                   | Formata os arquivos de configuração                                  |
| `terraform plan`                  | Mostra o que será criado/modificado/removido                         |
| `terraform apply`                 | Aplica as alterações de infraestrutura                               |
| `terraform destroy`               | Remove todos os recursos definidos                                   |
| `terraform output`                | Exibe os valores de saída definidos                                  |
| `terraform state list`            | Lista os recursos gerenciados no state file                          |
| `terraform taint <recurso>`       | Marca recurso para recriação no próximo apply                        |
| `terraform import <recurso> <id>` | Importa recursos existentes para o Terraform                         |

---

## 📦 Principais componentes

| Componente                           | Descrição                                                                        |
| ------------------------------------ | -------------------------------------------------------------------------------- |
| **Provider**                         | Plugin que permite interagir com serviços (ex: `aws`, `google`, `azurerm`)       |
| **Resource**                         | Bloco que define um recurso real (ex: `aws_instance`, `google_compute_instance`) |
| **Data source**                      | Permite buscar dados de outros recursos existentes para uso no código            |
| **Variable**                         | Parametriza valores reutilizáveis e dinâmicos                                    |
| **Output**                           | Exibe valores ao final do `apply`, como IPs e IDs                                |
| **Module**                           | Grupo reutilizável de recursos Terraform (boas práticas de organização)          |
| **Backend**                          | Define onde o **state file** será armazenado (local, S3, GCS, etc.)              |
| **State File (`terraform.tfstate`)** | Arquivo que mantém o estado atual da infraestrutura gerenciada                   |

---

## 📁 Estrutura de Projeto Sugerida

```
.
├── main.tf         # Arquivo principal com os recursos
├── variables.tf    # Declaração de variáveis
├── outputs.tf      # Saídas importantes
├── terraform.tfvars # Valores reais para variáveis
├── provider.tf     # Configuração dos providers (ex: AWS)
└── modules/        # Módulos reutilizáveis
```

---

## 🌍 Providers comuns

| Provider                  | Uso                                                             |
| ------------------------- | --------------------------------------------------------------- |
| `aws`                     | Provisione recursos na Amazon Web Services                      |
| `azurerm`                 | Provisione na Microsoft Azure                                   |
| `google`                  | Google Cloud Platform                                           |
| `kubernetes`              | Gerencie recursos dentro de clusters Kubernetes                 |
| `helm`                    | Instale charts do Helm em clusters K8s                          |
| `null`, `local`, `random` | Utilitários genéricos para scripts, arquivos e geração de dados |

---

## 🚀 Casos de uso

- Provisionamento automático de **infraestrutura em nuvem**
- Criação de ambientes de **teste, staging e produção**
- Implantação de **clusters Kubernetes**
- Configuração de **VPNs, Load Balancers, VPCs**
- Orquestração de recursos para **CI/CD**

---

## 📌 Boas práticas

- Use **modules** para reutilização e organização
- Armazene o **state remoto com locking** (ex: S3 + DynamoDB para AWS)
- Versione os arquivos `.tf` no **Git**
- Faça `terraform plan` antes de qualquer `apply`
- Use `terraform validate` e `fmt` em pipelines CI

---

## 🧪 Extras

- Pode ser usado com **Terraform Cloud/Enterprise** para colaboração, segurança e controle de mudanças.
- Integração com CI/CD (GitHub Actions, GitLab CI, Jenkins, etc.)
- Pode ser usado com **ArgoCD** e **Helm** para gerenciar clusters de forma declarativa.

---
