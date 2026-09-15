## USO_IA . md

Ferramenta : ChatGPT ( GPT -4 o )
Trecho : regra de tratamento de comentarios de bloco aninhados
Finalidade : pedi uma explicacao de como usar start conditions (% x ) do flex para tratar EOF dentro de um comentario aberto
O que fiz : entendi a explicacao e escrevi a regra sozinho ( a ), adaptando o padrao ao formato de erro exigido no enunciado ( Secao 4.1)

Ferramenta : ChatGPT ( GPT -5.6 Luna )

Trecho : tratamento de sequências de escape em constantes de string e caractere

Finalidade : pedi uma explicação sobre o significado da exigência de conversão de sequências de escape, especialmente \n, para o valor correto da constante

O que fiz : compreendi que \n deve representar um único caractere de nova linha no valor da STRINGCONST, em vez de permanecer como os dois caracteres \ e n

Ferramenta : ChatGPT ( GPT -5.6 Luna )

Trecho : conversão de sequências de escape em constantes de string

Finalidade : perguntei se o Flex possui uma estrutura pronta para modificar yytext e substituir sequências de escape

O que fiz : entendi que o Flex não fornece uma rotina automática de desescape e que a conversão deve ser feita por uma rotina auxiliar própria, preservando yytext como entrada

Ferramenta : ChatGPT ( GPT -5.6 Luna )

Trecho : processamento de sequências de escape em constantes de string

Finalidade : perguntei se seria possível usar uma subrotina no Flex com expressão regular e lookahead para identificar caracteres de escape

O que fiz : entendi que o processamento pode ser feito em uma subrotina C percorrendo yytext, sem depender de lookahead de regex

Ferramenta : ChatGPT ( GPT -5.6 Luna )

Trecho : Seção 4.1 — Tratamento de Erros

Finalidade : pedi uma explicação sobre o que cada item do tratamento de erros do scanner exige e como o scanner deve reagir a cada situação

O que fiz : usei a explicação para entender a diferença entre os tipos de erro léxico, as mensagens exigidas, o retorno de UNDEF e a forma de recuperação da leitura

Ferramenta : ChatGPT ( GPT -5.6 Luna )

Trecho : implementação da tabela de strings (tabelaStrings, adicionaString e retornaLexema)

Finalidade : pedi uma revisão da estrutura e das funções para verificar se a implementação da tabela dinâmica de strings estava correta

O que fiz : usei a explicação para identificar erros de declaração da estrutura, uso de arrays e ponteiros, passagem da tabela por valor, realloc, alocação redundante e tamanho de memória

Ferramenta : ChatGPT ( GPT -5.6 Luna )

Trecho : implementação da tabela de strings e da função adicionaString

Finalidade : pedi uma revisão da nova versão da tabela dinâmica para identificar erros restantes na manipulação do ponteiro da estrutura e no realloc

O que fiz : usei a explicação para identificar o uso incorreto de '.' em um ponteiro para tabela, o uso incorreto de tamanho no realloc e a necessidade de tratar a falha de alocação

Ferramenta : ChatGPT ( GPT -5.6 Luna )

Trecho : funções adicionaString e retornaLexema da tabela de strings

Finalidade : pedi uma revisão da versão atual para verificar se os acessos por ponteiro e a estrutura das funções estavam corretos

O que fiz : confirmei o uso correto de -> e identifiquei que ainda preciso tratar a falha de realloc e inicializar corretamente a tabela