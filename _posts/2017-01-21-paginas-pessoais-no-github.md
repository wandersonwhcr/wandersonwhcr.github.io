---
layout: post
title: "Páginas Pessoais no GitHub"
date: 2017-01-21
category: GitHub
---

Este primeiro artigo apresenta informações sobre como criar páginas estáticas pessoais no GitHub. Descreve-se, de forma breve, como um repositório do GitHub deve ser criado para que seja possível apresentar o conteúdo desejado.  Além disso, apresenta-se a ferramenta Jekyll para gerar conteúdos estáticos a partir de textos redigidos no formato Markdown.

# Introdução

Há cerca de 6 anos, eu tinha um _blog_ com conteúdos sobre programação, dedicado principalmente à linguagem de programação PHP e Zend Framework. Por mais incrível que pareça, o _blog_ era mais conhecido por uma sequência de artigos que descreviam como efetuar uma conexão _bluetooth_ entre computador executando Java e _smartphone_ com sistema operacional Android. Vai entender.

No final do ano passado eu tive que desligar a minha máquina virtual na [DigitalOcean](https://www.digitalocean.com/) por motivos pessoais e não consegui renovar o domínio no [Registro.BR](http://registro.br/). Como o _blog_ não era atualizado há um bom tempo, não fiz questão de buscar alternativas.

Nesta semana, após querer voltar a escrever, lembrei que o GitHub possibilita que seus usuários criem repositórios para apresentar conteúdos estáticos em HTTPS. Após analisar como este serviço funciona, decidi utilizá-lo e criar um artigo sobre como iniciar um repositório.

# Criando um Repositório

O [GitHub](https://github.com) possibilita que seus usuários criem dois tipos de páginas: pessoais ou de organaização e páginas de projetos. Vamos utilizar o primeiro tipo, sem relacionamento com projetos. Por exemplo, o usuário `wandersonwhcr` pode criar uma página estática acessível através do endereço `https://wandersonwhcr.github.io`. Note que o GitHub já disponibiliza as páginas através do protocolo HTTPS por padrão.

Primeiramente, temos que criar um repositório com o mesmo nome do subdomíno a ser utilizado. No caso acima, o nome do repositório ficará `wandersonwhcr.github.io`. Assim, [crie um novo repositório](https://github.com/new) com o seu domínio. No meu caso, o repositório com o código-fonte desta página está disponível no endereço abaixo.

[https://github.com/wandersonwhcr/wandersonwhcr.github.io](https://github.com/wandersonwhcr/wandersonwhcr.github.io)

Qualquer conteúdo estático adicionado ao _branch_ `master` do repositório será publicado na página pessoal. Todavia, o gerenciamento do conteúdo estático de forma manual pode ser trabalhosa, principalmente quando trabalhamos com _layouts_. Eis que surge o Jekyll, um gerenciador de conteúdos estáticos.

# Utilizando o Jekyll

A ferramenta de linha de comando [Jekyll](https://jekyllrb.com/) possibilita que os usuários transformem textos simples em páginas estáticas e _blogs_. Para iniciar um projeto no Jekyll, simplesmente execute o comando abaixo no diretório do projeto.

```bash
jekyll new . --force
```

Basicamente, este comando solicita ao Jekyll a criação de um novo projeto através do atributo `new`, no diretório atual `.`. O parâmetro `--force` faz com que o programa ignore arquivos que já existem no diretório, como, por exemplo, o diretório `.git` do versionamento.

Para visualizar o conteúdo criado, podemos utilizar o próprio _built-in server_ do Jekyll, executando o comando abaixo.

```bash
jekyll serve
```

Acessando o endereço `http://localhost:4000`, você poderá visualizar o conteúdo criado no formato HTML, conforme a figura abaixo.

![Conteúdo criado no formato HTML]({{ site.url }}/assets/img/2017-01-21-screenshot.png)

# Publicando o Conteúdo

Para publicar o conteúdo criado pelo Jekyll, basta versionar o código-fonte no _branch_ `master`, enviando-o ao GitHub. O conteúdo enviado será automaticamente convertido para HTML pelo serviço, pois o Jekyll é o _software_ para geração de páginas oficial do GitHub.

```bash
git add -A
git commit -m'Inicializa o repositório com Jekyll'
git push origin master
```

O conteúdo estará disponível conforme o repositório criado. No meu caso, o conteúdo está em `https://wandersonwhcr.github.io`.

# Conclusão

Existem muitas ferramentas para gerenciamento de conteúdo na Internet, como WordPress, Joomla e Drupal. Todavia, estas necessitam de recursos adicionais para execução, como um banco de dados.

Mesmo que estes sistemas sejam disponibilizados de forma gratuíta na Internet, podemos encontrar ferramentas mais simples, como as páginas do GitHub, que trabalham em conjunto com o Jekyll para tornar a criação de páginas estáticas mais acessível, principalmente para desenvolvedores.

Além disso, o serviço é **gratuíto** e disponibiliza todas as páginas, por padrão, utilizando o protocolo HTTPS, aumentando a privacidade dos dados transferidos entre requisições.

Por fim, as páginas do GitHub não são limitadas ao Jekyll, podendo ser geradas localmente e versionadas por qualquer gerenciador de conteúdo estático, como o [Couscous](http://couscous.io/) ou o [MkDocs](http://www.mkdocs.org/). Contudo, como não há suporte pelo GitHub para estas ferramentas, o conteúdo necessita ser gerado pelo desenvolvedor e versionado junto ao código-fonte, contrariando Mason (2005, p. 13, tradução livre), pois "se um arquivo pode ser reconstruído de outros arquivos, então o seu armazenamento será simplesmente uma duplicata".

# Referências

* [Jekyll: Simple, blog-aware and static sites](https://jekyllrb.com/)
* [GitHub Pages: Websites for you and your projects, hosted directly from GitHub repository](https://pages.github.com/)
* [Using Jekyll as a static site generator with GitHub Pages](https://help.github.com/articles/using-jekyll-as-a-static-site-generator-with-github-pages/)
* MASON, M. _Pragmatic Version Control Using Subversion_. The Pragmatic Programmers (2005).

# Veja Mais

* [StaticGen: Top open-source static site generators](https://www.staticgen.com/)
* [Jekyll Themes](http://jekyllthemes.org/)
