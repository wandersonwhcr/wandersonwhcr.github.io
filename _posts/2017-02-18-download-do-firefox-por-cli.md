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
