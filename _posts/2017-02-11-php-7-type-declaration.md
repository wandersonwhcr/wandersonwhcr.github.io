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
