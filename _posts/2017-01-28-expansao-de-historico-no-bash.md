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

O [GNU Bash](https://www.gnu.org/software/bash/) é um _shell_ compatível com `sh` que está disponível como padrão em muitas distribuições Linux. Facilitando o acesso para execução de programas no sistema operacional por CLI, também fornece comandos internos que facilitam sua utilização, como o `cd`.

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

# Consulta Reversa

Como o Bash utiliza a biblioteca `readline` na compilação, podemos utilizar recursos como o <kbd>CTRL</kbd>+<kbd>R</kbd> para pesquisa reversa no histórico. Ao pressionar esta sequência de teclas e após o conteúdo necessário, será efetuada uma pesquisa reversa no histórico atual. Ao encontrar o comando necessário, basta pressionar a tecla <kbd>ENTER</kbd>.

O exemplo abaixo limpa o histórico e executa 3 novos comandos no CLI. Após pressionar <kbd>CTRL</kbd>+<kbd>R</kbd>, efetuar a pesquisa por `ls` e pressionar a tecla <kbd>ENTER</kbd>, teremos executado o comando número 2 novamente.

```bash
$ history -c
$ ls -alsh >/dev/null
$ find . | grep one >/dev/null
(reverse-i-search)`ls': ls -alsh >/dev/null
```

# PS1 com Histórico

Também é possível adicionar a posição atual no histórico na variável `PS1` do Bash, através da expansão `\!`. O exemplo abaixo altera o `PS1` em tempo de execução, adicionando ao final da linha a posição atual do histórico.

```bash
$ history -c
$ PS1="$PS1[\\!] "
$ [2] echo "Hello, World!"
Hello, World!
```

Note que a expansão necessita do caractere de escape `\` na execução, tornando-se `\\!`. Caso queira alterar o `PS1` diretamente no arquivo `~/.bashrc`, não há necessidade de inclusão deste caractere.

# Conclusão

O Bash é um interpretador de comandos utilizado pelos usuários para execução de programas por CLI. Os comandos informados neste interpretador são registrados e podem ser consultados através do `history`, incluindo funcionalidades de expansão direta com `!` ou consulta reversa implementada pela biblioteca `readline`.

Por apresentar a simples funcionalidade de execução de comandos, algumas vezes o Bash pode ser pouco estudado pelos usuários, fazendo com que algumas tarefas cotidianas tornem-se tediosas, caso desconheçam estes recursos simples.

# Observações

Conforme [comentário](#comment-3129293460) do leitor [Guaracy Monteiro](https://guaracy.github.io/) neste artigo, pode-se [adicionar rótulos na linha de comando](https://guaracy.github.io/posts/rotulos-na-linha-de-comando/) através do caractere _hash_ (`#`), tratando-os como _hashtags_ para facilitar a pesquisa. O exemplo abaixo apresenta comandos simples com exemplos deste recurso.

```bash
$ ls -alsh #list
$ find . -name '*.mp3' #search #mp3
$ touch foobar #reset
```

Todas as informações após o caractere `#` serão tratadas como comentários pelo Bash. Porém, estes comentários podem ser encontrados através da [consulta reversa](#consulta-reversa) e <kbd>CTRL</kbd>+<kbd>R</kbd>. O próximo exemplo apresenta uma possível utilização de consulta de comandos com a _hashtag_ `#search`.

```bash
(reverse-i-search)`#search': find . -name '*.mp3' #search #mp3
```

Pressionando a sequência de teclas <kbd>CTRL</kbd>+<kbd>R</kbd> e informando o conteúdo de pesquisa `#search`, encontra-se o comando `find` para pesquisa de arquivos com a extensão `mp3`, informado anteriormente com a _hashtag_ da pesquisa.

# Referências

* [GNU Bash](https://www.gnu.org/software/bash/)
* [man.he.net: bash](http://man.he.net/?topic=bash&section=all)
* [Lornajane Blog: Navigating Bash History with Ctrl+R](https://lornajane.net/posts/2011/navigating-bash-history-with-ctrlr)
* [nixCraft: How to Change/Setup Bash Custom Prompt (PS1)](https://www.cyberciti.biz/tips/howto-linux-unix-bash-shell-setup-prompt.html)
* [Rótulos na Linha de Comando](https://guaracy.github.io/posts/rotulos-na-linha-de-comando/) por [Guaracy Monteiro](https://guaracy.github.io/)

# Veja Mais

* [GNU Readline Library, The](https://cnswww.cns.cwru.edu/php/chet/readline/rltop.html)
* [Bourne Shell (sh)](https://en.wikipedia.org/wiki/Bourne_shell)
