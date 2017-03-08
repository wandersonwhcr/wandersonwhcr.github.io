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

No caso anterior, após a configuração do adaptador com um objeto do tipo `Foo\AdapterInterface`, através do método `Foo\Bar::setAdapter`, não há a possibilidade de desconfiguração do atributo, fazendo com que o mesmo volte ao estado em tempo de construção. Para isto, pode-se adicionar um valor padrão `null` ao parâmetro `$adapter` do método em questão.

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

Ambos os casos possuem problemas de estrutura. O primeiro caso define que existe um valor padrão que, se ignorado durante a utilização do método, deve ser utilizado. Todavia, a chamada do método se torna pouco compreensível quando sem parâmetros, sendo que encapsulamentos do tipo `set` possuem a lógica de recebimento de parâmetros.

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

Por fim, caso o adaptador não esteja configurado, o acesso ao método `Foo\Bar::getAdapter` apresenta um problema, pois o retorno foi configurado com tipo explícito.

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
