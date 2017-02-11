---
layout: post
title: "PHP Iterable"
date: 2017-02-04
language: pt-br
category: PHP
---

Com a disponibilização do PHP 7.1, novos recursos foram adicionados à linguagem, incluindo o _pseudotype_ `iterable`. Este artigo apresenta uma introdução sobre este novo recurso, bem como exemplos de utilização.

## Introdução

O _pseudotype_ `iterable` foi adicionado a partir do aceite da [PHP RFC: Iterable](https://wiki.php.net/rfc/iterable), baseada no _pseudotype_ `callable` incluído na versão 5.4. Um _pseudotype_ (pseudotipo, em tradução livre), é um tipo utilizado pelo PHP para efetuar verificações de tipagem em tempo de execução, sendo que o `iterable` é usado para verificação de elementos que devem ser iteráveis e podem ser utilizados como entrada em estruturas _foreach_.

## Antes do Iterable

O exemplo abaixo apresenta um código-fonte para a classe de exemplo `Foo\Bar` que possui o método `setOptions`, responsável por configurar as possíveis opções internas de execução, que recebe como parâmetro um conjunto de opções que deve ser iterado através de uma estrutura _foreach_.

```php
<?php

namespace Foo;

use InvalidArgumentException;
use Traversable;

/**
 * Classe de Exemplo
 */
class Bar
{
    /**
     * Opções
     * @type array
     */
    protected $options = [];

    /**
     * Configura uma Opção
     *
     * @param  string $name  Nome
     * @param  string $value Valor
     * @return self   Próprio Objeto para Encadeamento
     */
    public function setOption(string $name, string $value)
    {
        $this->options[$name] = $value;
        return $this;
    }

    /**
     * Configura um Conjunto de Opções
     *
     * @param  array|Traversable        Valores para Configuração
     * @throws InvalidArgumentException Opções com Tipo Inválido
     * @return self                     Próprio Objeto para Encadeamento
     */
    public function setOptions($options) : self
    {
        // Tipagem Correta?
        if (! is_array($options) || ! $options instanceof Traversable) {
            throw new InvalidArgumentException('Invalid "$options" Type');
        }
        // Processamento
        foreach ($options as $name => $value) {
            $this->setOption($name, $value);
        }
        // Encadeamento
        return $this;
    }
}
```

Para tornar o código robusto, deve-se adicionar uma verificação antes da estrutura _foreach_, verificando se a variável `$options` é do tipo básico `array` ou é um objeto que pertence a uma classe que possui a _interface_ `Traversable` implementada. Com esta condicional, há a garantia de que a iteração será executada com sucesso.

## Aplicando o Iterable

Com a inclusão do _pseudotype_ `iterable` na versão 7.1 do PHP, a verificação de tipo iterável pode ser efetuada diretamente pela linguagem de programação, melhorando a compreensão do código-fonte. O método `Foo\Bar::setOptions` pode ser definido conforme o exemplo abaixo.

```php
<?php
    // ...

    /**
     * Configura um Conjunto de Opções
     *
     * @param  iterable Valores para Configuração
     * @return self     Próprio Objeto para Encadeamento
     */
    public function setOptions(iterable $options) : self
    {
        // Processamento
        foreach ($options as $name => $value) {
            $this->setOptions($name, $value);
        }
        // Encadeamento
        return $this;
    }

    // ...
```

Em resumo, a análise de tipagem do parâmetro `$options` fica a cargo da própria linguagem de programação, efetuando as mesmas verificações do exemplo anterior. Caso o parâmetro `$options` não seja do tipo básico `array` ou um objeto de uma classe que não implementa a _interface_ `Traversable`, o PHP efetuará um `throw` de uma exceção do tipo `TypeError`.

## Verificando Manualmente

Junto com o _pseudotype_ `iterable`, adicionou-se a função `is_iterable`, que verifica se o argumento passado é do tipo `iterable`. O próximo código-fonte apresenta um exemplo de utilização desta função.

```php
<?php

var_dump(is_iterable([])); // true
var_dump(is_iterable(new ArrayIterator())); // true
var_dump(is_iterable(1)); // false
var_dump(is_iterable('foobar')); // false
```

## Conclusão

A criação do _pseudotype_ `iterator` faz com que o código-fonte possua menos verificações de tipagem, fazendo com que ele seja mais robusto e compreensível através dos próprios recursos da linguagem de programação. Todavia, na data quando este artigo foi redigido, a documentação do PHP não recebeu informações sobre este novo recurso, somente apresentando a RFC de idealização.

Com a inclusão deste novo tipo, pode-se dizer que os autores do PHP estão abertos para mudanças, melhorando, assim, a tipagem fraca encontrada na linguagem.

## Referências

* [PHP 7.1.0 ChangeLog](http://php.net/ChangeLog-7.php#7.1.0)
* [PHP RFC: Iterable](https://wiki.php.net/rfc/iterable)
* [PHP TypeError Manual](https://secure.php.net/manual/en/class.typeerror.php)

## Veja Mais

* [PHP Traversable](http://php.net/manual/en/class.traversable.php)
* [PHP Callbacks and Callables](https://secure.php.net/manual/en/language.types.callable.php)
* [What's New in PHP 7.1: Iterable Types](https://www.youtube.com/watch?v=XKyGOxfm_cU)
