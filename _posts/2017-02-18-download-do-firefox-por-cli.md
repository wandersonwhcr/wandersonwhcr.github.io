---
layout: post
title: "Download do Firefox por CLI"
date: 2017-02-18
category: Linux
---

Este texto apresenta uma forma de efetuar o _download_ da última versão do Firefox, através de ferramentas de linha de comando (CLI), sem a utilização de navegadores Web. O recurso é extremamente importante quando existe a necessidade de instalação deste _software_ em distribuições GNU/Linux simples, como o Debian `netinst`.

## Introdução

Segundo o [DistroWatch](https://distrowatch.com/), há 288 distribuições GNU/Linux ou BSD cadastradas em seu banco de dados. Dentre estas distribuições, existem aquelas que possuem ambientes amigáveis ao usuário, como [Ubuntu](https://www.ubuntu.com/), [openSUSE](https://pt.opensuse.org/) e [Fedora](https://getfedora.org/pt_BR/), que buscam instalar todos os aplicativos básicos durante a instalação do sistema operacional.

Todavia, estes recursos adicionais, que facilitam a vida do usuário comum e tornam o ambiente mais amigável, consomem recursos desnecessários do _hardware_ onde estão instalados. Neste caso, existem outras distribuições, mais simples e completamente funcionais, que deixam a cargo do usuário a instalação destes recursos, como [Debian](https://www.debian.org/), [Alpine](https://alpinelinux.org/) e [Arch Linux](https://www.archlinux.org/).

Em máquinas pessoais, constumo utilizar o Debian com instalação por rede (conhecido como `netinst`), inserindo somente os pacotes necessários para que o sistema operacional funcione corretamente. Porém, o Debian não possui pacotes atualizados do Mozilla Firefox, navegador que utilizo, muito menos instala qualquer tipo de navegador Web.

Então, como fazer a instalação do Firefox sem um navegador?

## Download do Firefox

Existe um [documento](https://ftp.mozilla.org/pub/firefox/releases/latest/README.txt) disponibilizado no FTP da Mozilla que descreve uma URL para captura da última versão do Firefox através de ferramentas de linha de comando (CLI), como o `curl` ou `wget`. Esta URL recebe 3 parâmetros por GET, responsáveis por informar o tipo do produto, sistema operacional e linguagem.

Para efetuar o _download_ do Mozilla Firefox na sua última versão e sem a utilização de navegadores, para distribuições GNU/Linux de 64bits e linguagem `en-US`, basta utilizar o `wget`, com a seguinte linha de comando.

```bash
wget --trust-server-names \
    'https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=en-US'
```

| Parâmetro   | Valor            | Descrição                                   |
| ----------- | ---------------- | ------------------------------------------- |
| `product`   | `firefox-latest` | Última Versão do Mozilla Firefox Disponível |
| `os`        | `linux64`        | Sistema Operacional Alvo na Compilação      |
| `lang`      | `en-US`          | Linguagem (Idioma)                          |

O parâmetro `--trust-server-names` indica ao `wget` para utilizar os nomes de arquivos informados no servidor, onde neste caso, irá salvar em disco o arquivo compactado do Firefox com o prefixo `firefox-`, seguido pela versão atual e a extensão `.tar.bz2`, como, por exemplo, `firefox-51.0.1.tar.bz2`.

**Nota**: não esqueça de colocar entre aspas no parâmetro que contém a URL, pois há um `&` (_ampersand_ ou E comercial) que enviará o comando para _background_, se não escapado.

Para descompactar o conteúdo do arquivo, basta utilizar a ferramenta `tar`.

```bash
tar xjvf firefox*.tar.bz2
```

### Encadeando Comandos

Para melhorar os comandos informados anteriormente, podemos usufruir de _pipes_ e fazer com que o `wget` informe o conteúdo do arquivo compactado na saída padrão, descompactando-o diretamente com o `tar`, ignorando o nome do arquivo. Para isto, informe os seguintes comandos.

```bash
wget -O- --quiet \
    'https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=en-US' \
    | tar xvjf -
```
