# ☸️ Kubernetes - Visão Geral

## O que é o Kubernetes?

**Kubernetes** (ou **K8s**) é uma plataforma **open-source de orquestração de containers**, usada para **implantar, escalar, gerenciar e monitorar aplicações containerizadas**, como aquelas que rodam em Docker.

---

## 🧠 Como o Kubernetes funciona?

Kubernetes organiza os recursos em um **cluster**, composto por:

- **Master Node (Control Plane)**: onde ocorrem decisões de agendamento e controle.
- **Worker Nodes**: onde os containers realmente rodam.

### Componentes principais

| Componente                                              | Função                                                                                    |
| ------------------------------------------------------- | ----------------------------------------------------------------------------------------- |
| **Pod**                                                 | Menor unidade de execução. Pode conter um ou mais containers.                             |
| **Node**                                                | Máquina (física ou virtual) que executa os pods.                                          |
| **Deployment**                                          | Gerencia a criação e ciclo de vida dos pods (réplicas, updates, rollback).                |
| **Service**                                             | Exposição dos pods para acesso interno/externo. Tipos: LoadBalancer, ClusterIP, NodePort. |
| **ReplicaSet**                                          | Garante que o número desejado de pods esteja em execução.                                 |
| **Namespace**                                           | Separa recursos em grupos lógicos (multi-tenant).                                         |
| **ConfigMap / Secret**                                  | Armazenam variáveis de ambiente e dados sensíveis.                                        |
| **PersistentVolume (PV) / PersistentVolumeClaim (PVC)** | Usados para armazenamento de dados persistentes.                                          |
| **Ingress**                                             | Roteia requisições HTTP/HTTPS externas para serviços internos.                            |
| **Probes**                                              | Verificam a saúde e disponibilidade dos containers.                                       |

### 🔍 Tipos de Probes

| Probe                | Finalidade                                                                                      |
| -------------------- | ----------------------------------------------------------------------------------------------- |
| **`livenessProbe`**  | Verifica se o container está em execução. Se falhar, o container será reiniciado.               |
| **`readinessProbe`** | Verifica se o container está pronto para receber tráfego. Se falhar, ele é removido do Service. |
| **`startupProbe`**   | Verifica se a aplicação foi iniciada corretamente. Ideal para apps que demoram a iniciar.       |

```yaml
livenessProbe:
  httpGet:
    path: /healthz
    port: 8080
  initialDelaySeconds: 3
  periodSeconds: 10

readinessProbe:
  httpGet:
    path: /ready
    port: 8080
  initialDelaySeconds: 5
  periodSeconds: 10

startupProbe:
  httpGet:
    path: /startup
    port: 8080
  failureThreshold: 30
  periodSeconds: 10
```

---

## 🧰 Principais Ferramentas do Ecossistema

### 🧑‍💻 `kubectl`

| Comando                                        | Descrição                                                         |
| ---------------------------------------------- | ----------------------------------------------------------------- |
| `kubectl get pods`                             | Lista todos os pods                                               |
| `kubectl get svc`                              | Lista todos os serviços                                           |
| `kubectl get deployments`                      | Lista todos os deployments                                        |
| `kubectl get nodes`                            | Lista todos os nós do cluster                                     |
| `kubectl get namespaces`                       | Lista todos os namespaces                                         |
| `kubectl get events`                           | Lista eventos recentes                                            |
| `kubectl get all`                              | Lista todos os recursos no namespace atual                        |
| `kubectl describe pod <nome>`                  | Mostra detalhes de um pod                                         |
| `kubectl describe node <nome>`                 | Mostra detalhes de um node                                        |
| `kubectl logs <pod>`                           | Exibe logs de um pod                                              |
| `kubectl logs -f <pod>`                        | Exibe logs em tempo real                                          |
| `kubectl exec -it <pod> -- bash`               | Acessa um pod com bash                                            |
| `kubectl apply -f <arquivo.yaml>`              | Aplica um arquivo de configuração                                 |
| `kubectl delete -f <arquivo.yaml>`             | Remove recursos definidos no arquivo                              |
| `kubectl create namespace <nome>`              | Cria um novo namespace                                            |
| `kubectl delete namespace <nome>`              | Remove um namespace                                               |
| `kubectl scale deployment <nome> --replicas=N` | Altera a quantidade de réplicas de um deployment                  |
| `kubectl rollout restart deployment <nome>`    | Reinicia um deployment                                            |
| `kubectl rollout undo deployment <nome>`       | Realiza rollback de um deployment                                 |
| `kubectl top pod`                              | Mostra uso de CPU e memória por pod (requer metrics-server)       |
| `kubectl top node`                             | Mostra uso de CPU e memória por nó                                |
| `kubectl config get-contexts`                  | Mostra todos os contextos configurados                            |
| `kubectl config use-context <contexto>`        | Troca o contexto ativo                                            |
| `kubectl port-forward pod/<nome> 8080:80`      | Redireciona porta local para o pod                                |
| `kubectl port-forward svc/<nome> 8080:80`      | Redireciona porta local para o service                            |
| `kubectl cp <pod>:/caminho/origem ./destino`   | Copia arquivos de dentro do pod para local                        |
| `kubectl edit deployment <nome>`               | Edita um deployment diretamente no editor padrão                  |
| `kubectl get pvc`                              | Lista os volumes persistentes declarados (PersistentVolumeClaims) |
| `kubectl get pv`                               | Lista volumes persistentes (PersistentVolumes)                    |
| `kubectl delete pod <nome>`                    | Deleta um pod específico                                          |
| `kubectl explain pod`                          | Mostra a definição detalhada de um recurso (ex: estrutura do Pod) |

```yaml
resources:
  requests:
    memory: "256Mi"
    cpu: "250m"
  limits:
    memory: "512Mi"
    cpu: "500m"
```

---

### 📈 HPA - Horizontal Pod Autoscaler

```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: minha-api-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: minha-api
  minReplicas: 2
  maxReplicas: 10
  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: 70
```

---

### 📉 VPA - Vertical Pod Autoscaler

```yaml
apiVersion: autoscaling.k8s.io/v1
kind: VerticalPodAutoscaler
metadata:
  name: minha-api-vpa
spec:
  targetRef:
    apiVersion: "apps/v1"
    kind: Deployment
    name: minha-api
  updatePolicy:
    updateMode: "Auto"
```

---

## 🧱 StatefulSets & Headless Services

### 🧩 StatefulSet

```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: meu-banco
spec:
  serviceName: "meu-banco"
  replicas: 3
  selector:
    matchLabels:
      app: banco
  template:
    metadata:
      labels:
        app: banco
    spec:
      containers:
        - name: postgres
          image: postgres:15
          ports:
            - containerPort: 5432
          volumeMounts:
            - name: dados
              mountPath: /var/lib/postgresql/data
  volumeClaimTemplates:
    - metadata:
        name: dados
      spec:
        accessModes: ["ReadWriteOnce"]
        resources:
          requests:
            storage: 5Gi
```

---

### 🧭 Headless Service

```yaml
apiVersion: v1
kind: Service
metadata:
  name: meu-banco
spec:
  clusterIP: None
  selector:
    app: banco
  ports:
    - port: 5432
```

---

## 🔐 Namespaces, Contexts, Service Accounts e Roles

### 🗂️ Namespaces

```bash
kubectl get namespaces
kubectl create namespace meu-ambiente
kubectl get pods -n meu-ambiente
```

---

### 🔄 Contexts

```bash
kubectl config get-contexts
kubectl config use-context meu-contexto
```

---

### 👤 Service Accounts

```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: minha-sa
```

```yaml
spec:
  serviceAccountName: minha-sa
```

---

### 🛡️ Roles e RoleBindings

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: meu-ambiente
  name: pod-reader
rules:
  - apiGroups: [""]
    resources: ["pods"]
    verbs: ["get", "list", "watch"]
```

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: read-pods
  namespace: meu-ambiente
subjects:
  - kind: ServiceAccount
    name: minha-sa
    namespace: meu-ambiente
roleRef:
  kind: Role
  name: pod-reader
  apiGroup: rbac.authorization.k8s.io
```

---

## 🔄 Benefícios e Finalidade

- ✅ Alta disponibilidade
- 📈 Escalabilidade automática
- ⚖️ Balanceamento de carga
- 🛠️ Atualizações com rollbacks automáticos
- 📜 Infraestrutura como código (YAML)
- 💡 Observabilidade com probes

---

## 📝 Extras

- Declaratividade como princípio
- Suporte a vários container runtimes (Docker, containerd, CRI-O)
- Ideal para microserviços e arquiteturas modernas
