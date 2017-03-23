---
layout: post
title: "Alfaiate Git: Merges"
date: 2017-03-11
category: Git
---

Continuando a sequência de artigos sobre como tornar a linha de desenvolvimento do Git mais amigável, este documento apresenta informações sobre como coser um nó final de _branch_ na linha do tempo principal, reintegrando-o.

## Merges

Swicegood (2008) define _merge_ como capturar dois ou mais _branches_ e combinar suas histórias numa só. Sink (2011) complementa que convergência de _branches_ é feita através de _merge_, tornando a operação simples, automatizando-a.

Basicamente, a reintegração de uma divergência à linha de tempo principal é efetuada através de um _merge_, onde o nó final desta deve ser cosido de forma que a linha permaneça coerente.

{% include image.html src="/assets/img/2017-02-25-screenshot-3.png" description="Fonte: Elaborado pelo Autor" alt="Exemplo de Linha do Tempo com Padrões" %}

A figura acima apresenta a estrutura de exemplo criada no artigo anterior, possuindo três _branches_ que devem ser reintegrados: `issue-1`, `issue-2` e `issue-3`. Nota-se, ainda, que todos os _branches_ possuem o mesmo nó base, apontado pelo _branch_ `master`.

## Referências

* SWICEGOOD, T. _Pragmatic Version Control Using Git_. Pragmatic Bookshelf (2008).
* SINK, E. _Version Control by Example_. Pyrenean Gold Press (2011).
