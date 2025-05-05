# Padrões e Técnicas Avançadas com Git e GitHub

- Git Pull
- Code Review
- Configurações para proteções de branchs
- Pull Requests / Templates para PRs
- Plugins do Visual Studio Code
- SemVer (Semantical Version)
- Convetional Commits
- Codeowners

## Extensão Git Flow

wget -q https://raw.githubusercontent.com/petervanderdoes/gitflow-avh/develop/contrib/gitflow-installer.sh && sudo bash gitflow-installer.sh install stable; rm gitflow-installer.sh

## Comandos do Git Flow

git flow init

git feature start [name]

git feture finish [name]

git release start [name]

git release finish [name]

## Assinatura de commits

gpg --full-generate-key

gpg --list-secret-key --keyid-form LONG

gpg --armor --export [key-id]

GitHub > Settings > SSH and GPG Keys

git config --global user.signingkey [key-id]

add on .bashrc this config export GPG_TTY=$(tty)

git config --global commit.gpgsign true

git config --global tag.gpgsign true

git log --show-signature -1

## Boas práticas para repositórios

Deixar bancho develop como default

- Settings > Branches > Default branchs > Develop

Adicionar proteção de branchs

- Exigir code reviews
- Exigir pull requests
- Exigir commits assinados
- Exigir que todos os status check estejam OK antes de fazer merge (testes, sonar, build etc)
- Restringir que pode fazer pode fazer merge diretamente na branch

Criar um template para as pull requests

Adicionar os codeowners responsáveis do projeto

## Semantical Versioning

- Major (Api pública disponível)
- Minor (Adicionado funcionalidades, mas compatível com a API)
- Patch (Bugs, ajustes)

Ex: v1.2.7

Major 0 - API Instavel, pode mudar a qualquer momento

v1.0.0-alpha
v1.0.0-beta

## Conventional Commits

Uma especificação para dar siguinificado legível as mensagens de commit para humanos e máquinas

Sempre escreva de forma imperativa (Corrido, ajustado, adicionado)

<tipo>[escopo opcional]: descrição

[corpo]

[rodapé]

Diferentes tipos

- refactor!: Remove suporte para Node 18 (BREAKING CHANGE)

- fix
- feat
- chore
- build
- ci
- docs
- style
- refactor
- perf
- test
