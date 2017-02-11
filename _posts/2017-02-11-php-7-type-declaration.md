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
