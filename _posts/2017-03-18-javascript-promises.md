---
layout: post
title: "JavaScript Promises"
date: 2017-03-18
category: JavaScript
---

O presente artigo apresenta uma breve introdução sobre JavaScript Promises (promessas, em tradução livre), estruturas que facilitam a execução assíncrona de elementos encadeados.

## Introdução

Uma `Promise` é um objeto que manipula valores de forma assíncrona e que não são necessariamente reconhecidos no momento de sua criação (MOZILLA 2017). Basicamente, uma `Promise` representa um bloco de código que pode não finalizar a sua execução no momento em que é executado, sendo paralelizado no momento de sua criação, evitando, assim, o bloqueio do fluxo de execução principal.

O exemplo abaixo apresenta a execução assíncrona de um cálculo qualquer, através de Promises.

```js
/**
 * Executa um Cálculo Qualquer
 * @type Promise
 */
var calcSomethingPromise = new Promise(function (resolve, reject) {
    var counter = 0;
    var limit   = Math.pow(10, 10);

    for (var i = 0; i <= limit; i++) {
        counter = counter + 1;
    }

    resolve(counter);
});
```

Nota-se que um objeto do tipo `Promise` foi inicializado através de seu construtor, recebendo como parâmetro uma _closure_ que possui dois parâmetros: `resolve` e `reject`. Ambos parâmetros também são do tipo _closure_, onde `resolve` deve ser utilizado quando há sucesso de execução, e o `reject` quando um erro foi encontrado.

## Referências

* MOZILLA. _Promise_. Disponível em [https://developer.mozilla.org/pt-BR/docs/Web/JavaScript/Reference/Global\_Objects/Promise](https://developer.mozilla.org/pt-BR/docs/Web/JavaScript/Reference/Global_Objects/Promise). Acesso em 18/03/2017.
