---
layout: post
title: "PHP Iterable"
date: 2017-02-04
category: PHP
---

Com a disponibilização do PHP 7.1, novos recursos foram adicionados à linguagem, incluindo o _pseudotype_ `iterable`. Este artigo apresenta uma introdução sobre este novo recurso, bem como exemplos de utilização.

## Introdução

O _pseudotype_ `iterable` foi adicionado a partir do aceite da [PHP RFC: Iterable](https://wiki.php.net/rfc/iterable), baseada no _pseudotype_ `callable` incluído na versão 5.4. Um _pseudotype_ (pseudotipo, em tradução livre), é um tipo utilizado pelo PHP para efetuar verificações de tipagem em tempo de execução, sendo que o `iterable` é usado para verificação de elementos que são iteráveis e podem ser utilizados como entrada em estruturas _foreach_.

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
     * @param  array|Traversable Valores para Configuração
     * @return self              Próprio Objeto para Encadeamento
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
