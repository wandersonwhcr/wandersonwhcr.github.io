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

## Execução

Quando uma `Promise` é construída, ela automaticamente inicia a sua execução de forma assíncrona. Uma Promise pode estar em três estados distintos, dependendo da sua execução atual.

* _pending_ (pendente): onde esta ainda não foi resolvida ou rejeitada;
* _fullfilled_ (realizada): a execução foi finalizada com sucesso através da _closure_ `resolve`;
* _rejected_ (rejeitada): seu processamento foi rejeitado com a _closure_ `reject`.

O estado de uma `Promise` não pode ser acessado. Todavia, deve-se utilizar os métodos `then` e `catch` para encadeamento de outras _closures_. Estes métodos também retornam novas Promises, caracterizando o padrão de projeto _fluent interface_.

```js
// Cálculo Qualquer
calcSomethingPromise
    // Sucesso 1: Cria Objeto Totalizador
    .then(function (counter) {
        return {'total': counter};
    })
    // Sucesso 2: Apresenta Informações no Console
    .then(function (element) {
        console.info(element);
    })
    // Erro: Impossível Continuar
    .catch(function (message) {
        console.error(message);
    });
```

O exemplo anterior adiciona três _closures_ de execução. A primeira _closure_ configurada com o método `then`, recebe como parâmetro o resultado de contabilização informado em `resolve`, interno à estrutura da Promise. Já a segunda _closure_ do método `then`, recebe como parâmetro o resultado da primeira, apresentando no _console_ o elemento construído anteriormente. Por fim, a terceira _closure_ pelo método `catch`, contém o tratamento de erro caso `reject` seja executado.

Constata-se que as _closures_ configuradas pelo método `then` são executadas posteriormente ao cálculo e caso algum erro seja apresentado, o tratamento pode ser aplicado no método `catch`. Ainda, caso uma destes fluxos de execução apresente uma exceção através de um `throw`, o método `catch` é invocado, recebendo como parâmetro a mensagem de erro.

## Referências

* MOZILLA. _Promise_. Disponível em [https://developer.mozilla.org/pt-BR/docs/Web/JavaScript/Reference/Global\_Objects/Promise](https://developer.mozilla.org/pt-BR/docs/Web/JavaScript/Reference/Global_Objects/Promise). Acesso em 18/03/2017.

## Veja Mais

* [Wikipedia: Fluent Interface](https://en.wikipedia.org/wiki/Fluent_interface)
