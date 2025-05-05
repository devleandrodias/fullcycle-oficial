# 📘 Padrões e Técnicas Avançadas com Git e GitHub

Este guia reúne boas práticas, ferramentas e convenções para manter repositórios bem organizados, seguros e com histórico de commits legível.

---

## ✅ Fluxo de Trabalho com Git

### Git Pull e Code Review

- Sempre atualize sua branch local com `git pull origin develop` antes de começar a trabalhar.
- Participe ativamente dos **code reviews**, garantindo qualidade e aprendizado coletivo.

### Proteções de Branch

Configure em **Settings > Branches**:

- Defina `develop` como a branch padrão.
- Exija:
  - Pull Requests obrigatórios.
  - Aprovações em code review.
  - Commits assinados (GPG).
  - Status checks bem-sucedidos (build, lint, testes).
  - Restrições de merge direto (somente via PR).

---

## 🔀 Git Flow

### Instalação da Extensão

```bash
wget -q https://raw.githubusercontent.com/petervanderdoes/gitflow-avh/develop/contrib/gitflow-installer.sh && sudo bash gitflow-installer.sh install stable && rm gitflow-installer.sh
```

### Comandos Principais

```bash
git flow init
git flow feature start [nome]
git flow feature finish [nome]
git flow release start [versão]
git flow release finish [versão]
```

---

## 🔏 Assinatura de Commits (GPG)

### Geração de Chave

```bash
gpg --full-generate-key
gpg --list-secret-key --keyid-form LONG
gpg --armor --export [key-id]
```

### Configuração no GitHub

- Vá em: `Settings > SSH and GPG Keys`
- Adicione a chave pública gerada.

### Configuração no Git

```bash
git config --global user.signingkey [key-id]
echo 'export GPG_TTY=$(tty)' >> ~/.bashrc
git config --global commit.gpgsign true
git config --global tag.gpgsign true
```

### Verificação

```bash
git log --show-signature -1
```

---

## 🔃 Pull Requests e Templates

- Crie um **template padrão** para Pull Requests (`.github/pull_request_template.md`).
- Ele deve conter:
  - Objetivo da PR
  - Cards do Jira vinculados
  - Checklist de revisão (testes, lint, cobertura)
  - Screenshots ou evidências se necessário

---

## 👥 Codeowners

- Use o arquivo `.github/CODEOWNERS` para definir responsáveis por revisões.

```plaintext
# Exemplo
/src/frontend/ @frontend-team
/src/backend/  @backend-team
```

---

## 📌 Versionamento Semântico (SemVer)

Formato: `v[MAJOR].[MINOR].[PATCH]`

| Tipo  | Descrição                                 |
| ----- | ----------------------------------------- |
| MAJOR | Mudanças incompatíveis (BREAKING CHANGES) |
| MINOR | Novas funcionalidades (compatíveis)       |
| PATCH | Correções de bugs ou melhorias pequenas   |

Exemplos:

- `v1.0.0-alpha` (prévia instável)
- `v2.1.3` (release estável)

---

## 🧠 Conventional Commits

> Convenção de mensagens de commit legíveis por humanos e ferramentas de automação.

### Estrutura:

```bash
<tipo>[escopo opcional]: descrição curta

[corpo opcional]

[rodapé opcional, ex: BREAKING CHANGE ou referência a issue]
```

### Exemplos:

```bash
feat(auth): adiciona fluxo de login via Google
fix(order): corrige erro ao calcular frete
refactor!: remove suporte ao Node 18
```

### Tipos Comuns:

- `feat`: Nova funcionalidade
- `fix`: Correção de bug
- `docs`: Mudança em documentação
- `style`: Estilo (formatação, semântico)
- `refactor`: Refatoração de código
- `perf`: Melhoria de performance
- `test`: Testes
- `build`: Configs de build
- `ci`: Integração contínua
- `chore`: Outras tarefas (ex: atualização de deps)

---

## 🛠️ Ferramentas para Padronização de Commits

- [`Commitizen`](https://github.com/commitizen/cz-cli): CLI interativo para commits convencionais.
- [`Commitlint`](https://github.com/conventional-changelog/commitlint): Linter de mensagens de commit.
- [`Husky`](https://github.com/typicode/husky): Hooks para rodar lint, testes, etc., antes de commit/push.
- [`Commitsar`](https://github.com/aevea/commitsar): Verifica se commits seguem Conventional Commits.
