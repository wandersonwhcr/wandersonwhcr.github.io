---
layout: post
title: "PHP 7 Type Declaration"
date: 2017-02-11
category: PHP
---

Este documento apresenta as novidades do PHP 7 sobre tipos de declaração de parâmetros, conhecidas anteriormente como _type hinting_. Inclui, ainda, exemplos de utilização e possíveis erros que podem ser encontrados durante sua utilização.

## Introdução

Além de melhorias de desempenho, o PHP 7 trouxe novidades com relação à estrutura da linguagem. Agora, pode-se declarar parâmetros de métodos e funções com tipos básicos da linguagem, e não somente os tipos `array`, `object`, `self`, _pseudotypes_, classes ou interfaces.

Esta técnica, anteriormente conhecida como _type hinting_, teve seu nome modificado para _type declarations_ (declarações de tipos, em tradução livre), possivelmente porque agora é possível utilizar os tipos `bool`, `float`, `int` e `string`.

## Antes do Novo Recurso

O exemplo abaixo apresenta um código-fonte para a classe `Foo\Bar` que possui métodos simples que necessitam de parâmetros com tipos básicos da linguagem.

```php
<?php

namespace Foo;

use InvalidArgumentException;

/**
 * Classe de Exemplo
 */
class Bar
{
    /**
     * Nome
     * @type string
     */
    protected $name = '';

    /**
     * Modificador
     * @type float
     */
    protected $modifier = 1.0;

    /**
     * Ordem Crescente?
     * @type bool
     */
    protected $ascending = true;

    /**
     * Limite
     * @type int
     */
    protected $limit = PHP_INT_MAX;

    /**
     * Configura o Nome
     *
     * @param  string                   $name Valor para Configuração
     * @throws InvalidArgumentException Valor com Tipo Inválido
     * @return self                     Próprio Objeto para Encadeamento
     */
    public function setName($name) : self
    {
        // Tipagem Correta?
        if (! is_string($name)) {
            throw new InvalidArgumentException('Invalid "$name" Type');
        }
        // Configuração
        $this->name = $name;
        // Encadeamento
        return $this;
    }

    /**
     * Configura o Modificador
     *
     * @param  float                    $modifier Valor para Configuração
     * @throws InvalidArgumentException Valor com Tipo Inválido
     * @return self                     Próprio Objeto para Encadeamento
     */
    public function setModifier($modifier) : self
    {
        // Tipagem Correta?
        if (! is_float($modifier)) {
            throw new InvalidArgumentException('Invalid "$modifier" Type');
        }
        // Configuração
        $this->modifier = $modifier;
        // Encadeamento
        return $this;
    }

    /**
     * Configura a Ordem Crescente
     *
     * @param  bool                     $ascending Valor para Configuração
     * @throws InvalidArgumentException Valor com Tipo Inválido
     * @return self                     Próprio Objeto para Encadeamento
     */
    public function setAscending($ascending) : self
    {
        // Tipagem Correta?
        if (! is_bool($ascending)) {
            throw new InvalidArgumentException('Invalid "$ascending" Type');
        }
        // Configuração
        $this->ascending = $ascending;
        // Encadeamento
        return $this;
    }

    /**
     * Configura o Limite
     *
     * @param  int                      $limit Valor para Configuração
     * @throws InvalidArgumentException Valor com Tipo Inválido
     * @return self                     Próprio Objeto para Encadeamento
     */
    public function setLimit($limit) : self
    {
        // Tipagem Correta?
        if (! is_int($limit)) {
            throw new InvalidArgumentException('Invalid "$limit" Type');
        }
        // Configuração
        $this->limit = $limit;
        // Encadeamento
        return $this;
    }
}
```

Nota-se que as verificações de tipos de dados informados como parâmetros ficam a cargo do programador, deixando o código-fonte pouco robusto. Para cada método informado, caso exista a necessidade de que certo tipo específico de dado seja apresentado, adiciona-se uma condicional que verifica o tipo correto, e, em caso de erro, atira-se uma exceção do tipo `InvalidArgumentException`.

## Aplicando Declarações de Tipos

Agora no PHP 7 é possível utilizar declarações para garantir a passagem dos tipos básicos. O próximo código-fonte contém a mesma estrutura do exemplo anterior, porém com as novas declarações de tipo disponíveis.

```php
<?php
    // ...

    /**
     * Configura o Nome
     *
     * @param  string $name Valor para Configuração
     * @return self   Próprio Objeto para Encadeamento
     */
    public function setName(string $name) : self
    {
        // Configuração
        $this->name = $name;
        // Encadeamento
        return $this;
    }

    /**
     * Configura o Modificador
     *
     * @param  float $modifier Valor para Configuração
     * @return self  Próprio Objeto para Encadeamento
     */
    public function setModifier(float $modifier) : self
    {
        // Configuração
        $this->modifier = $modifier;
        // Encadeamento
        return $this;
    }

    /**
     * Configura a Ordem Crescente
     *
     * @param  bool $ascending Valor para Configuração
     * @return self Próprio Objeto para Encadeamento
     */
    public function setAscending(bool $ascending) : self
    {
        // Configuração
        $this->ascending = $ascending;
        // Encadeamento
        return $this;
    }

    /**
     * Configura o Limite
     *
     * @param  int  $limit Valor para Configuração
     * @return self Próprio Objeto para Encadeamento
     */
    public function setLimit(int $limit) : self
    {
        // Configuração
        $this->limit = $limit;
        // Encadeamento
        return $this;
    }

    // ...
```

Nota-se, agora, que os tipos básicos podem ser adicionados para garantir a tipagem da informação. Quando um parâmetro pertence a outro tipo, este sofre um _type casting_ ou conversão de tipo, em tradução livre, pela própria linguagem. Ainda, se o PHP não conseguir efetuar a conversão, uma exceção do tipo `TypeError` é apresentada pela linguagem em tempo de execução.

```php
<?php

$element = new Foo\Bar();

$element
    ->setName(Foo\Bar::class)
    ->setModifier(1)
    ->setAscending('0')
    ->setLimit(3.1415);

var_dump($element);
/*
object(Foo\Bar)#1 (4) {
  ["name":protected]=>
  string(7) "Foo\Bar"
  ["modifier":protected]=>
  float(1)
  ["ascending":protected]=>
  bool(false)
  ["limit":protected]=>
  int(3)
}
*/
```

O exemplo acima demonstra a utilização de um objeto da classe `Foo\Bar`, configurando-o com suporte a declarações de tipo disponíveis. Constata-se que os tipos das variáveis foram convertidos automaticamente pelo PHP, conforme declarações. Ainda, alguns casos demonstram perda de informação, como no método `Foo\Bar::setLimit`, onde há a conversão do tipo `float` com o valor `3.1415` para o tipo `int` com o valor `3`.

## Aumentando a Confiabilidade

Para evitar que seja efetuada a conversão automática de tipos, mesmo em casos que esta ação é possível, pode-se adicionar uma declaração, por arquivo, informando ao PHP que todos as declarações de tipo devem ser estritamente verificadas. Quando o valor informado é incondizente com o tipo configurado, uma exceção do tipo `TypeError` é atirada em tempo de execução.

```php
<?php

declare(strict_types=1);

namespace Foo;

/**
 * Classe de Exemplo
 */
class Bar
{
    // ...
}
```

## Erros Comuns

Um erro comum, durante o início da utilização da declaração de tipos do PHP 7 pelo programador, é utilizar o tipo `boolean`. Todavia, o tipo `boolean` não é um tipo básico do PHP, mas sim o `bool`. Ainda, quando adiciona-se o tipo `boolean` como declaração de tipo, o PHP irá interpretar esta informação como o **nome de uma classe** e não como o tipo básico.

```php
<?php

(function (boolean $checked) {
    var_dump($checked);
})(true);

/*
Fatal error: Uncaught TypeError:
Argument 1 passed to {closure}() must be an instance of boolean, boolean given,
called in [...][...] on line 5 and defined in [...][...]:3

Stack trace:
#0 [...][...](5): {closure}(true)
#1 {main}
  thrown in [...][...] on line 3
*/
```

Ainda, outro caso comum é a conversão que não é efetuada entre alguns tipos, como de `array` vazio para `boolean` `false`, contrariando uma **conversão explícita**, possível na linguagem.

```php
<?php

$container = [];
$converted = (bool) $container;

var_dump($converted);

(function (bool $converted) {
    var_dump($converted);
})($container);

/*
bool(false)

Fatal error: Uncaught TypeError:
Argument 1 passed to {closure}() must be of the type boolean, array given,
called in [...][...] on line 10 and defined in [...][...]:8
Stack trace:
#0 [...][...](10): {closure}(Array)
#1 {main}
  thrown in [...][...] on line 8
*/
```

## Conclusão

A inclusão dos tipos básicos como declarações de parâmetros em métodos e funções do PHP melhora a legibilidade do código-fonte, uma vez que o programa necessita de menos verificações explícitas em seu conteúdo para garantir a tipagem dos valores. Ainda, este novo recurso torna a execução mais robusta, fazendo com que a própria linguagem efetue as análises necessárias em tempo de execução.

Por outro lado, existem ainda alguns erros comuns que podem causar problemas durante o desenvolvimento, principalmente por programadores iniciantes na linguagem e que desconhecem alguns estranhos comportamentos internos.

Assim, reitero, que o conhecimento profundo de qualquer linguagem é extremamente necessário para programadores que buscam desenvolver códigos mais saudáveis e com menos _bugs_.

## Referências

* [PHP: Type Declarations](http://php.net/manual/en/functions.arguments.php#functions.arguments.type-declaration)
* [PHP: Strict Typing](http://php.net/manual/en/functions.arguments.php#functions.arguments.type-declaration.strict)
