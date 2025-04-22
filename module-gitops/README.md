# 🚀 GitOps & ArgoCD - Visão Geral e Boas Práticas

## 📘 O que é GitOps?

**GitOps** é uma abordagem que utiliza o Git como **fonte única de verdade** para **infraestrutura e aplicações**, permitindo que mudanças sejam aplicadas de forma automatizada e controlada no ambiente Kubernetes.

### 🧩 Princípios do GitOps

- ✅ **Infraestrutura como Código** (IaC)
- 🔁 **Pipelines Automatizados** com reconciliação contínua
- 📜 **Controle de versão** com Git (auditável e reversível)
- 👁️ **Observabilidade e auditoria** via histórico de commits
- 🔒 **Segurança e consistência** ao aplicar mudanças via Git

---

## 🛠️ O que é o ArgoCD?

**ArgoCD** é uma ferramenta open source de **Continuous Delivery** (CD) que implementa GitOps para clusters Kubernetes.

### Funcionalidades principais:

- Monitoramento contínuo de repositórios Git
- Deploy automático em clusters Kubernetes
- Suporte a YAML puro, Helm, Kustomize, Jsonnet, etc.
- Interface Web com visualização dos estados dos recursos
- Histórico de sincronizações e fácil rollback
- Multi-cluster management e RBAC

---

## 🔄 Como funciona o fluxo GitOps com ArgoCD?

1. Você **commita** o manifesto no Git
2. O **ArgoCD detecta** a mudança
3. Ele **compara o estado atual com o desejado**
4. **Aplica as mudanças** automaticamente ou sob aprovação
5. O cluster é **reconciliado com o Git**

---

## ✅ Boas Práticas com GitOps e ArgoCD

| Prática                                     | Descrição                                                                    |
| ------------------------------------------- | ---------------------------------------------------------------------------- |
| 📁 **Separação de repositórios**            | Um para código da app, outro para manifests                                  |
| 🔀 **Branches por ambiente**                | `dev`, `staging`, `prod` com PRs protegidos                                  |
| 🔒 **Princípio do menor privilégio (RBAC)** | ServiceAccounts com permissões mínimas                                       |
| 🔍 **Observabilidade**                      | Habilitar logs, notificações e hooks                                         |
| 🧪 **Descrever declarativamente**           | Preferir YAML, Helm ou Kustomize                                             |
| 🔁 **Sync automática com cuidado**          | Use `auto-sync` com `prune: true` e `selfHeal: true` apenas quando confiante |
| 🧱 **Organização clara**                    | Diretórios por app/ambiente, exemplo: `apps/prod/api/`                       |
| 🧰 **Uso de health checks e hooks**         | Executar scripts antes/depois do deploy                                      |
| 🔐 **Proteção de segredos**                 | Use SealedSecrets, SOPS, Vault ou ArgoCD Vault Plugin                        |

---

## 📄 Exemplo de Application no ArgoCD

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: minha-api-prod
  namespace: argocd
spec:
  project: default
  source:
    repoURL: "https://github.com/empresa/projeto-k8s-manifests"
    targetRevision: HEAD
    path: apps/prod/minha-api
  destination:
    server: "https://kubernetes.default.svc"
    namespace: prod
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
    syncOptions:
      - CreateNamespace=true
```

---

## 🧠 Dicas adicionais

- 🔐 Habilite **SSO (OIDC, SAML)** para acesso seguro ao ArgoCD
- 🧭 Utilize **App of Apps Pattern** para gerenciar múltiplas aplicações
- 📋 Ative **auditoria de alterações** com logs e histórico
- 📦 Utilize **Helm + Kustomize** para reuso de templates
- 🛡️ Limite acesso com RBAC e `Projects` no ArgoCD

---

## 🔗 Referências Úteis

- [ArgoCD Docs](https://argo-cd.readthedocs.io/)
- [GitOps Tech](https://www.gitops.tech/)
- [GitOps CNCF Principles](https://github.com/open-gitops/documents)
