---
layout: post
title: "Alfaiate Git: Branches"
date: 2017-02-25
category: Git
---

Assim como o código-fonte, a estrutura do versionamento de _software_ necessita de cuidados, visando melhor compreensão e manutenção. O conteúdo aqui presente inicia uma sequência de artigos que dialogam sobre como tornar a linha de desenvolvimento do Git mais amigável, onde cada ponto dado na linha do tempo deve valoroso e perfeito.

## Linha do Tempo

Um sistema de controle de versões é um _software_ habilita um time de desenvolvedores de _software_ a trabalharem em grupo, armazenando a história de seu trabalho (SINK, 2011). A história deste trabalho é salva como uma sequência de passos, descrevendo, basicamente, como o código-fonte do _software_ foi modificado em determinado período, caracterizando, assim, uma linha do tempo.

{% include image.html src="/assets/img/2017-02-25-screenshot-1.png" description="Fonte: Elaborado pelo Autor" alt="Exemplo de Linha do Tempo" %}

A imagem anterior apresenta uma captura de tela parcial do Gitk, exibindo a linha do tempo entre as versões `1.4.0` e `1.4.1` do [repositório desta página](https://github.com/wandersonwhcr/wandersonwhcr.github.io). Nota-se que, para cada alteração efetuada, existe um nó na linha do tempo.

Assim como um alfaiate, esta linha pode ser "costurada", onde cada nó é cosido de forma organizada, propondo-se obter o melhor produto final.

## Branches

O principal recurso que diferencia o Git de outros sistemas de controle de versões é o seu modelo de _branches_ independentes (GIT, 2017). Segundo Chacon e Straub (2014), A criação de um _branch_ informa ao Git um afastamento de uma linha do tempo qualquer, separando as novas alterações que deverão ser aplicadas.

Um _branch_ pode ser criado em qualquer ponto da linha do tempo e referencia um nó. Porém, quando os _branches_ são criados sem a padronização de nós base, há uma possibilidade de confusão durante a leitura da linha do tempo.

{% include image.html src="/assets/img/2017-02-25-screenshot-2.png" description="Fonte: Elaborado pelo Autor" alt="Exemplo de Linha do Tempo" %}

A figura anterior demonstra uma captura de tela parcial do Gitk para o [repositório oficial do Zend DB](https://github.com/zendframework/zend-db). Sabe-se que o Git possui uma ótima resolução de integração de afastamento de linhas, porém a leitura deste repositório em busca de informações, torna-se complicada quando não há padronização de um nó raiz durante a criação de _branches_.

## Referências

* SINK, E. _Version Control by Example_. Pyrenean Gold Press (2011).
* GIT. _About Git_. Disponível em: [https://git-scm.com/about](https://git-scm.com/about). Acesso em: 25 de fev. de 2017.
* CHACON, S.; STRAUB, B. _Pro Git_. Apress (2014).
