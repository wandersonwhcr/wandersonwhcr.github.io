---
layout: post
title: "Páginas Pessoais no GitHub"
date: 2017-01-20
category: GitHub
---

Este primeiro artigo apresenta informações sobre como criar páginas estáticas pessoais no GitHub. Descreve-se, de forma breve, como um repositório do GitHub deve ser criado para que seja possível apresentar o conteúdo desejado.  Além disso, apresenta-se a ferramenta Jekyll para gerar conteúdos estáticos a partir de textos redigidos no formato Markdown.

# Introdução

Há cerca de 6 anos, eu tinha um _blog_ com conteúdos sobre programação, dedicado principalmente à linguagem de programação PHP e Zend Framework. Por mais incrível que pareça, o _blog_ era mais conhecido por uma sequência de artigos que descreviam como efetuar uma conexão _bluetooth_ entre computador executando Java e _smartphone_ com sistema operacional Android. Vai entender.

No final do ano passado eu tive que desligar a minha máquina virtual na Digital Ocean por motivos pessoais e não consegui renovar o domínio na Registro BR. Como o _blog_ não era atualizado há um bom tempo, não fiz questão de buscar alternativas.

Nesta semana, após querer voltar a escrever, lembrei que o GitHub possibilita que seus usuários criem repositórios para apresentar conteúdos estáticos por HTTPS. Após analisar como este serviço funciona, decidi utilizá-lo e criar um artigo sobre como iniciar um repositório.

# Criando um Repositório

O [GitHub](https://github.com) possibilita que seus usuários criem dois tipos de páginas: pessoais ou de organaização e páginas de projetos. Vamos utilizar o primeiro tipo, sem relacionamento com projetos. Por exemplo, o usuário `wandersonwhcr` pode criar uma página estática acessível através do endereço `https://wandersonwhcr.github.io`. Note que o GitHub já disponibiliza as páginas através do protocolo HTTPS por padrão.

Primeiramente, temos que criar um repositório com o mesmo nome do subdomíno a ser utilizado. No caso acima, o nome do repositório ficará `wandersonwhcr.github.io`. Assim, [crie um novo repositório](https://github.com/new) com o seu domínio. No meu caso, o repositório com o código-fonte desta página está disponível no endereço abaixo.

[https://github.com/wandersonwhcr/wandersonwhcr.github.io](https://github.com/wandersonwhcr/wandersonwhcr.github.io)

Qualquer conteúdo estático adicionado ao _branch_ _master_ do repositório será publicado na página pessoal. Todavia, o gerenciamento do conteúdo estático de forma manual pode ser trabalhosa, principalmente quando trabalhamos com _layouts_. Eis que surge o Jekyll, um gerenciador de conteúdos estáticos.

# Utilizando o Jekyll

A ferramenta de linha de comando [Jekyll](https://jekyllrb.com/) possibilita que os usuários transformem textos simples em páginas estáticas e _blogs_.
