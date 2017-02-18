---
layout: post
title: "Download do Firefox por CLI"
date: 2017-02-18
category: Linux
---

Este texto apresenta uma forma de efetuar o _download_ da última versão do Firefox, através de ferramentas de linha de comando (CLI), sem a utilização de navegadores Web. O recurso é extremamente importante quando existe a necessidade de instalação deste _software_ em distribuições GNU/Linux simples, como o Debian `netinst`.

## Introdução

Segundo o [DistroWatch](https://distrowatch.com/), há 288 distribuições GNU/Linux ou BSD conhecidas. Dentre estas distribuições, existem aquelas que possuem ambientes amigáveis ao usuário, como [Ubuntu](https://www.ubuntu.com/), [openSUSE](https://pt.opensuse.org/) e [Fedora](https://getfedora.org/pt_BR/), que disponibilizam todos os aplicativos básicos durante a instalação do sistema operacional.

Todavia, estes recursos adicionais, que tornam o ambiente mais amigável, consomem recursos desnecessários do _hardware_ onde estão instalados. Quando este assunto se torna prioridade, existem outras distribuições, mais simples e completamente funcionais, que deixam a cargo do usuário a instalação de pacotes adicionais, como [Debian](https://www.debian.org/), [Alpine](https://alpinelinux.org/) e [Arch Linux](https://www.archlinux.org/).

Pode-se utilizar o Debian com instalação por rede, conhecido como `netinst`, que proporciona somente os pacotes necessários para o funcionamento correto do sistema operacional. Contudo, o Debian não possui pacotes atualizados do Mozilla Firefox, _browser_ amplamente utilizado, muito menos instala, por padrão, qualquer tipo de navegador Web.

Então, como fazer a instalação do Firefox sem um navegador?

## Download do Firefox

Existe um [documento](https://ftp.mozilla.org/pub/firefox/releases/latest/README.txt), disponibilizado no FTP da Mozilla, que descreve uma URL para captura da última versão do Firefox através de ferramentas de linha de comando (CLI), como o `curl` ou `wget`. Esta URL recebe 3 parâmetros pelo método HTTP GET, responsáveis por informar o tipo do produto, sistema operacional e linguagem.

Para efetuar o _download_ do Mozilla Firefox na sua última versão e sem a utilização de navegadores, para distribuições GNU/Linux de 64bits e linguagem `en-US`, utiliza-se o `wget`, com a seguinte linha de comando.

```bash
wget --trust-server-names \
    'https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=en-US'
```

| Parâmetro   | Valor            | Descrição                                   |
| ----------- | ---------------- | ------------------------------------------- |
| `product`   | `firefox-latest` | Última Versão do Mozilla Firefox Disponível |
| `os`        | `linux64`        | Sistema Operacional Alvo na Compilação      |
| `lang`      | `en-US`          | Linguagem (Idioma)                          |

O parâmetro `--trust-server-names` indica ao `wget` para utilizar os nomes de arquivos informados no servidor, onde neste caso, irá salvar em disco o arquivo compactado do Firefox com o prefixo `firefox-`, seguido pela versão atual, e a extensão `.tar.bz2`, como, por exemplo, `firefox-51.0.1.tar.bz2`.

**Nota**: deve-se colocar entre aspas o parâmetro que contém a URL, pois há um `&` (_ampersand_ ou E comercial) que, se não escapado, enviará o comando para _background_.

Para descompactar o conteúdo do arquivo, emprega-se a ferramenta `tar`.

```bash
tar xjvf firefox*.tar.bz2
```

### Encadeando Comandos

Para melhorar os comandos informados anteriormente, pode-se usufruir de _pipes_, fazendo com que o `wget` informe o conteúdo do arquivo compactado na saída padrão, descompactando-o diretamente com o `tar`, ignorando, assim, o nome do arquivo. Para isto, informe os seguintes comandos.

```bash
wget -O- --quiet \
    'https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=en-US' \
    | tar xvjf -
```

## Finalização

Existem documentações que estão amplamente disponíveis, com fácil acesso, e existem aquelas satirizadas por Douglas Adams em seu maravilhoso livro, _O Guia do Mochileiro das Galáxias_.

Quando os Vogons chegam para destruir a Terra e a população entra em desespero, o representante do Conselho de Planejamento do Hiperespaço Galáctico demonstra espanto:

> "Esta supresa é injustificável. Todos os planos do projeto, bem como a ordem de demolição, estão em exposição no seu departamento local de planejamento, em Alfa do Centauro, há 50 dos seus anos terrestres, e portanto todos vocês tiveram muito tempo para apresentar qualquer reclamação formal, e agora é tarde demais para criar caso." (ADAMS, 2009, p. 44)

Assim como na ficção, documentações sobre ótimos recursos podem estar relativamente escondidas. Embora esta não seja responsável pela destruição de nosso único lar, acredita-se que irá, pelo menos, reduzir em alguns minutos a busca e instalação do Firefox em novas distribuições GNU/Linux.

## Referências

* [DistroWatch: Search for All Linux Distributions](https://distrowatch.com/search.php?status=All&ostype=Linux)
* [Mozilla Release Engineering](https://ftp.mozilla.org/pub/firefox/releases/latest/README.txt)
* [man.he.net: wget](http://man.he.net/?topic=wget&section=all)
* [man.he.net: tar](http://man.he.net/?topic=tar&section=all)
* ADAMS, D. _Guia do Mochileiro das Galáxias, O_. Tradução por: DA COSTA, C. I., BRITTO, P. F. H. Rio de Janeiro: Sextante (2009).

## Veja Mais

* [Wikipedia: List of Linux Distributions](https://en.wikipedia.org/wiki/List_of_Linux_distributions)
