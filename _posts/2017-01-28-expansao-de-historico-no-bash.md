---
layout: post
title: "Expansão de Histórico no Bash"
date: 2017-01-28
category: Linux
---

O presente artigo apresenta o comando `history` do Bash e como ele pode ser utilizado como ferramenta para execução de comandos armazenados no histórico. Ainda, informa como configurar o `PS1` para que este exiba a posição em que o comando será armazenado no histórico.

# Introdução

Nesta semana eu tive que efetuar o _backup_ de bancos de dados PostgreSQL, armazenados no ambiente de homologação, para a minha máquina de desenvolvimento, buscando encontrar alguns _bugs_ apresentados naquele local. Durante a execução do `pg_restore`, este apresentou avisos de que não tinha encontrado o usuário utilizado no banco de dados de homologação no desenvolvimento.

Para corrigir o problema, tive que executar 3 comandos distintos, para alterar as permissões em tabelas, visualizações e sequências. O problema é que eu tive que reinstalar o banco de dados inúmeras vezes para encontrar os malditos _bugs_, sempre executando aqueles 3 comandos através do `history`.

# Acessando o Histórico

O [GNU/Bash](https://www.gnu.org/software/bash/) é um _shell_ compatível com `sh` que está disponível como padrão em muitas distribuições Linux. Facilitando o acesso para execução de programas no sistema operacional por CLI, também fornece comandos internos que facilitam sua utilização, como o `cd`.

O `history` é um comando interno ao Bash que fornece ao usuário a possibilidade de visualizar e executar novamente comandos previamente informados. O exemplo abaixo apresenta alguns comandos do dia a dia de qualquer usuário do Bash.

```bash
$ mkdir test
$ cd test
$ mkdir one two three
$ touch one/foo two/bar three/baz
$ find . -type f
./two/bar
./three/baz
./one/foo
```

Ao digitar o comando `history`, teremos a seguinte saída:

```bash
$ history
    1  mkdir test
    2  cd test
    3  mkdir one two three
    4  touch one/foo two/bar three/baz
    5  find . -type f
```

Como podemos notar, a primeira coluna da saída possui um número sequencial, informando a posição do comando no histórico do Bash. Por sua vez, a segunda coluna possui a saída do comando informado naquele momento. Simples.

Tendo conhecimento desta listagem, o usuário pode solicitar ao Bash a execução do comando `touch` armazenado na posição `4` através da expansão de histórico `!`.

```bash
$ !4
touch one/foo two/bar three/baz
```

Também é possível solicitar a execução dos comandos `4` e `5` em sequência.

```bash
$ !4; !5
touch one/foo two/bar three/baz; find . -type f
./two/bar
./three/baz
./one/foo
```

Como o comando `!` representa uma expansão no Bash, então podemos utilizá-lo de muitas maneiras como, por exemplo, armazenando-os em arquivos para posterior consulta.

```bash
$ echo !4 > command.out
echo touch one/foo two/bar three/baz > command.out
$ cat command.out
touch one/foo two/bar three/baz
```

# Limpeza

O arquivo responsável por armazenar o histórico de comandos encontra-se em `~/.bash_history` e sua limpeza pode ser efetuada da seguinte forma.

```bash
$ history -c
$ history
    1  history
```
