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
