---
layout: post
title: "Alfaiate Git: Merges"
date: 2017-03-11
category: Git
---

Continuando a sequência de artigos sobre como tornar a linha de desenvolvimento do Git mais amigável, este documento apresenta informações sobre como coser um nó final de _branch_ na linha do tempo de desenvolvimento, reintegrando-o.

{% include index-alfaiate-git.md current=2 %}

## Merges

Swicegood (2008) define _merge_ como capturar dois ou mais _branches_ e combinar suas histórias numa só. Sink (2011) complementa que a convergência de _branches_ é feita através de _merge_, tornando a operação simples, automatizando-a.

Basicamente, a reintegração de uma história divergente à linha de tempo principal é efetuada através de um _merge_, onde o nó final desta deve ser cosido de forma que a linha permaneça coerente.

{% include image.html src="/assets/img/2017-02-25-screenshot-3.png" description="Fonte: Elaborado pelo Autor" alt="Exemplo de Linha do Tempo com Padrões" %}

A figura acima apresenta a estrutura de exemplo criada no artigo anterior, possuindo três _branches_ que devem ser reintegrados: `issue-1`, `issue-2` e `issue-3`. Nota-se, ainda, que todos os _branches_ possuem o mesmo nó base, apontado pelo _branch_ `master`.

## Reintegrando Nós

A partir da estrutura anterior, deve-se integrar os _branches_ `issue-3`, `issue-1` e `issue-2`, nesta ordem, no _branch_ `develop`, exemplificando assim, a ação de _merges_ em _branches_ divergentes. Para tanto, os seguintes comandos devem ser executados.

```bash
$ git checkout develop
$ git merge --no-ff issue-3
$ git merge --no-ff issue-1
$ git merge --no-ff issue-2
```

O parâmetro `--no-ff` (_no fast forward_, sem avanço rápido, em tradução livre), é utilizado para criar um nó adicional na linha do tempo, facilitando buscas posteriores para o ponto exato onde determinado _branch_ foi reintegrado, informando, assim, que naquele ponto, aplicou-se um _merge_.

{% include image.html src="/assets/img/2017-03-11-screenshot.png" description="Fonte: Elaborado pelo Autor" alt="Reintegração de Histórias Divergentes" %}

Observa-se o avanço na linha do tempo do _branch_ `develop`, onde este recebe as alterações pertinentas aos _branches_ reintegrados. Ainda, cada _merge_ contém uma mensagem, adicionada automaticamente pelo Git, informando que o nó foi incluído a partir de um _merge_ de determinado _branch_.

## Costura Impecável

As linhas de nós secundários foram, portanto, cosidas na linha do tempo de desenvolvimento. Dessa maneira, sabe-se quais os _branches_ foram costurados na linha de desenvolvimento, devido à nomenclatura de _branches_ com números de _issues_ e à mensagem padrão adicionada pelo Git durante o _merge_.

Todos os _branches_ saem do mesmo ponto e entram sequencialmente no _branch_ `develop`. O _branch_ `master` não deve ser utilizado diretamente, pois representa a versão estável do sistema, sendo sincronizado com o _branch_ `develop` somente durante a publicação de novas versões.

## Histórico

O comando abaixo apresenta a ordem com que os nós foram criados e reintegrados no _branch_ `develop`, apresentando os nós adicionais sequencialmente.

```bash
$ git log --oneline
0394c22 Merge branch 'issue-2' into develop
8a5798f Merge branch 'issue-1' into develop
c3ba031 Merge branch 'issue-3' into develop
86175fc Fecha documento
3eb7c60 Adiciona conteúdo de teste
3c90a79 Começa um novo documento
d10490d Inclui novos conteúdos
7794b88 Adiciona a primeira linha
c287efc Adiciona conteúdo de exemplo
bdf5275 Inicializa o repositório
```

O próximo artigo explicará como sincronizar o _branch_ principal `master` com o _branch_ de desenvolvimento `develop`, criando uma nova versão no repositório através de _tags_.

## Referências

* SWICEGOOD, T. _Pragmatic Version Control Using Git_. Pragmatic Bookshelf (2008).
* SINK, E. _Version Control by Example_. Pyrenean Gold Press (2011).

## Veja Mais

* [Atlassian: Git Merge](https://www.atlassian.com/git/tutorials/git-merge)
* [Codexico: Tutorial Simples Parte 2 Git Branch e Merge](http://codexico.com.br/blog/linux/tutorial-simples-parte-2-git-branch-e-merge/)
