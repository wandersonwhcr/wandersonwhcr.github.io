---
layout: post
title: "PHP Nullable Types"
date: 2017-03-04
category: PHP
---

O PHP 7 trouxe novidades com relação a tipos de declaração de parâmetros, possibilitando que estes sejam declarados explicitamente com os tipos `bool`, `float`, `int` e `string`. Seguindo esta linha de pensamento, incluiu-se no PHP 7.1 a capacidade de configurar estes parâmetros tipados com valores `null`, tanto para tipos básicos como complexos.

## Antes do Novo Recurso

O exemplo abaixo apresenta um código-fonte para a classe `Foo\Bar` que possui um método simples de encapsulamento.

```php
<?php

namespace Foo;

/**
 * Classe de Exemplo
 */
class Bar
{
    /**
     * Adaptador
     * @type AdapterInterface
     */
    protected $adapter;

    /**
     * Configura o Adaptador
     *
     * @param  $adapter AdapterInterface Valor para Configuração
     * @return self     Próprio Objeto para Encadeamento
     */
    public function setAdapter(AdapterInterface $adapter) : self
    {
        // Configuração
        $this->adapter = $adapter;
        // Encadeamento
        return $this;
    }

    /**
     * Apresenta o Adaptador
     *
     * @return AdapterInterface Valor Configurado
     */
    public function getAdapter() : AdapterInterface
    {
        // Apresentação
        return $this->adapter;
    }
}
```

No caso anterior, após a configuração do adaptador com um objeto do tipo `Foo\AdapterInterface`, através do método `Foo\Bar::setAdapter`, não há a possibilidade de desconfiguração do atributo, podendo fazer com que o mesmo volte ao estado em tempo de construção. Para isto, pode-se adicionar um valor padrão `null` ao parâmetro `$adapter` do método em questão.

```php
<?php
    // ...

    public function setAdapter(AdapterInterface $adapter = null) : self
    {
        // Configuração
        $this->adapter = $adapter;
        // Encadeamento
        return $this;
    }

    // ...
```

Ou, ainda, adicionar um novo método, responsável pela desconfiguração do atributo.

```php
<?php
    // ...

    public function unsetAdapter() : self
    {
        // Configuração
        $this->adapter = null;
        // Encadeamento
        return $this;
    }

    // ...
```

Ambos os casos possuem problemas de capacidade de escrita. O primeiro caso define que existe um valor padrão que, se ignorado durante a utilização do método, deve ser utilizado. Todavia, a chamada do método se torna pouco compreensível quando sem parâmetros, sendo que encapsulamentos do tipo `set` possuem a lógica de recebimento de valores em seus parâmetros.

```php
<?php

// Construção
$element = new Foo\Bar();
// Desconfigura Adaptador
$element->setAdapter();

var_dump($element);

/*
object(Foo\Bar)#1 (1) {
  ["adapter":protected]=>
  NULL
}
*/
```

Já o segundo, adiciona um método que executa nenhuma funcionalidade importante e que, dependendo da quantidade de atributos que devem usufruir desta necessidade, quebra-se facilmente a regra [_ExcessivePublicCount_](https://phpmd.org/rules/codesize.html#excessivepubliccount) do PHPMD.

```php
<?php

// Construção
$element = new Foo\Bar();
// Desconfigura Adaptador
$element->unsetAdapter();

var_dump($element);

/*
object(Foo\Bar)#1 (1) {
  ["adapter":protected]=>
  NULL
}
*/
```

Por fim, caso o adaptador não esteja configurado, o acesso ao método `Foo\Bar::getAdapter` apresenta um erro, pois o retorno foi configurado com tipo explícito.

```php
<?php

// Construção
$element = new Foo\Bar();
// Acesso
$element->getAdapter();

/*
Fatal error:  Uncaught TypeError: Return value of Foo\Bar::getAdapter()
  must be an instance of Foo\AdapterInterface, null returned in [...][...]:38
Stack trace:
#0 [...][...](6): Foo\Bar->getAdapter()
#1 {main}
  thrown in [...][...] on line 38
*/
```

## Aplicando Nullable Types

Com a utilização dos _nullable types_ (tipos anuláveis, em tradução livre) disponíveis no PHP 7.1, adiciona-se o caractere `?` antes do tipo explícido, informando à linguagem de programação que o valor passado pode ser aquele específico ou `null`. O exemplo abaixo apresenta a classe `Foo\Bar` com sua estrutura modificada, usufruindo dos tipos anuláveis.

```php
<?php

namespace Foo;

/**
 * Classe de Exemplo
 */
class Bar
{
    /**
     * Adaptador
     * @type AdapterInterface|null
     */
    protected $adapter;

    /**
     * Configura o Adaptador
     *
     * @param  $adapter AdapterInterface|null Valor para Configuração
     * @return self     Próprio Objeto para Encadeamento
     */
    public function setAdapter(?AdapterInterface $adapter) : self
    {
        // Configuração
        $this->adapter = $adapter;
        // Encadeamento
        return $this;
    }

    /**
     * Apresenta o Adaptador
     *
     * @return AdapterInterface|null Valor Configurado
     */
    public function getAdapter() : ?AdapterInterface
    {
        // Apresentação
        return $this->adapter;
    }
}
```

Os tipos anuláveis, contrariando o valor padrão apresentado anteriormente no primeiro caso, obrigam que seja informado o valor do parâmetro definido no método, mesmo que este seja `null`. Ainda, o método de acesso ao encapsulamento não apresentará erros, pois há a informação de que o seu retorno pode ser nula.

```php
<?php

// Construção
$element = new Foo\Bar();
// Desconfigura Adaptador
$element->setAdapter(null);

var_dump($element->getAdapter());

/*
NULL
*/
```

## Conclusão

A disponibilização da versão 7 do PHP traz mudanças importantes para os desenvolvedores que usufruem da linguagem. A própria inclusão da [declaração de tipos básicos]({{ site.baseurl }}{% post_url 2017-02-11-php-7-e-declaracao-de-tipos %}) significa um grande avanço com relação à tipagem.

Com a inclusão dos tipos anuláveis na linguagem, os códigos-fonte tendem a reduzir o tamanho e aumentar a confiabilidade. Todavia, a legibilidade do caractere `?` pode apresentar problemas, pois, o autor deste texto desconhece outra linguagem de programação que utiliza a mesma estrutura.
