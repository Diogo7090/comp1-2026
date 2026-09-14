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

Trecho : armazenamento do valor convertido de STRINGCONST e CHARCONST

Finalidade : perguntei como armazenar o lexema depois de substituir as sequências de escape sem modificar yytext

O que fiz : entendi que yytext deve ser usado como entrada da conversão e que o resultado deve ser construído em outra string/buffer, que então será armazenada como Symbol

Ferramenta : ChatGPT ( GPT -5.6 Luna )

Trecho : rotina substituirSeqEscape para tratamento de sequências de escape

Finalidade : pedi ajuda para identificar a causa de um problema de realce sintático no trecho case '"' e para revisar possíveis erros no código que escrevi

O que fiz : usei a explicação para identificar que case '"' e charInserir = '"' são válidos em C e que havia um problema no uso de ponteiro e char na rotina

Ferramenta : ChatGPT ( GPT -5.6 Luna )

Trecho : rotina substituirSeqEscape para conversão de sequências de escape

Finalidade : pedi uma revisão do código que escrevi para identificar erros na implementação da conversão de sequências de escape

O que fiz : usei a explicação para identificar problemas de ponteiros, avanço no texto de entrada, caracteres normais não tratados, possível uso de variável não inicializada e perda do ponteiro para o início do buffer de saída

Ferramenta : ChatGPT ( GPT -5.6 Luna )

Trecho : rotina substituirSeqEscape para conversão de sequências de escape

Finalidade : pedi uma revisão da implementação atual da rotina para verificar os erros restantes na conversão de sequências de escape

O que fiz : identifiquei o erro no acesso ao próximo caractere e compreendi que a conversão de uma sequência de dois caracteres para um único caractere exige separar posição de leitura e posição de escrita