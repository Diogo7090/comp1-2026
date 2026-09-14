%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* ---------------------------------------------------------------------
 * 1. VOCABULARIO DE TOKENS (equivalente a tokens.h)
 * ------------------------------------------------------------------- */

typedef enum {
    /* Tokens fundamentais */
    TK_UNDEF,          /* token indefinido (usado para reportar erros) */
    TK_ID,             /* identificador                                */
    TK_END_OF_FILE,    /* fim de arquivo                                */

    /* Constantes literais */
    TK_INTEGERCONST,
    TK_CHARCONST,
    TK_STRINGCONST,

    /* Operadores aritmeticos */
    TK_PLUS, TK_MINUS, TK_MUL, TK_DIV, TK_MOD,

    /* Operadores relacionais e logicos */
    TK_EQ, TK_NEQ, TK_LT, TK_GT, TK_LEQ, TK_GEQ, TK_AND, TK_OR, TK_NOT,

    /* Simbolos de atribuicao e pontuacao */
    TK_ASSIGN, TK_SEMICOLON, TK_COMMA, TK_LPAREN, TK_RPAREN,
    TK_LBRACE, TK_RBRACE, TK_LBRACKET, TK_RBRACKET,

    /* Palavras reservadas */
    TK_MAIN, TK_IF, TK_ELSE, TK_FOR, TK_RETURN, TK_INT, TK_CHAR, TK_PRINT
} TokenType;

/* Nomes dos tokens, usados apenas pelo main() de teste abaixo para
 * imprimir o tipo de cada token de forma legivel. Mantenha esta lista
 * na MESMA ORDEM do enum TokenType. */
static const char *nome_token[] = {
    "TK_UNDEF", "TK_ID", "TK_END_OF_FILE",
    "TK_INTEGERCONST", "TK_CHARCONST", "TK_STRINGCONST",
    "TK_PLUS", "TK_MINUS", "TK_MUL", "TK_DIV", "TK_MOD",
    "TK_EQ", "TK_NEQ", "TK_LT", "TK_GT", "TK_LEQ", "TK_GEQ", "TK_AND", "TK_OR", "TK_NOT",
    "TK_ASSIGN", "TK_SEMICOLON", "TK_COMMA", "TK_LPAREN", "TK_RPAREN",
    "TK_LBRACE", "TK_RBRACE", "TK_LBRACKET", "TK_RBRACKET",
    "TK_MAIN", "TK_IF", "TK_ELSE", "TK_FOR", "TK_RETURN", "TK_INT", "TK_CHAR", "TK_PRINT"
};

/* Valor semantico do token corrente. */
typedef struct {
    char *symbol;      /* lexema para ID, INTEGERCONST, CHARCONST, STRINGCONST */
    char *error_msg;   /* mensagem de erro, usada apenas quando tipo == UNDEF   */
} YYSTYPE;

YYSTYPE microc_yylval;

/* Linha atual do arquivo-fonte sendo processado. Deve ser incrementada
 * toda vez que uma quebra de linha for consumida pelo scanner (seja em
 * codigo "normal", dentro de comentarios ou dentro de strings). */
int linha_atual = 1;
int coluna_atual = 1;

/* Funcao auxiliar para preencher microc_yylval.symbol com uma copia do
 * texto reconhecido (yytext). Sinta-se livre para usar/adaptar. */
static void guarda_lexema(void) {
    microc_yylval.symbol = strdup(yytext);
}

%}

/* -----------------------------------------------------------------------
 * 2. SECAO DE DEFINICOES
 * ------------------------------------------------------------------- */

DIGIT       [0-9]
LETRA       [a-zA-Z_]
ALFANUM     [a-zA-Z0-9_]

%x COMMENT

%%

 /* -----------------------------------------------------------------------
  * 3. SECAO DE REGRAS
  * --------------------------------------------------------------------- */


<<EOF>>             { return TK_END_OF_FILE; }

\n                  { linha_atual++; coluna_atual=1;}
[ \t\r]+            { /* ignora espacos em branco */ coluna_atual+=1;}

"//".*              { /* comentario de linha: ignora ate o fim da linha */ }

"/*"                { BEGIN(COMMENT); }
<COMMENT>"*/"       { BEGIN(INITIAL); }
<COMMENT>\n         { linha_atual++; }
<COMMENT><<EOF>>    {
                        microc_yylval.error_msg = "EOF em comentario";
                        return TK_UNDEF;
                    }
<COMMENT>.          { /* consome qualquer outro caractere dentro do comentario */ }

"*/"                {
                        microc_yylval.error_msg = "Comentario nao iniciado";
                        return TK_UNDEF;
                    }

{LETRA}{ALFANUM}*   {
    if (strcmp(yytext, "if")==0){
        return TK_IF;
    }
    if (strcmp(yytext, "main")==0){
        return TK_MAIN;
    }
    if (strcmp(yytext, "int")==0){
        return TK_INT;
    }
    if (strcmp(yytext, "else")==0){
        return TK_ELSE;
    }
    if (strcmp(yytext, "for")==0){
        return TK_FOR;
    }
    if (strcmp(yytext, "return")==0){
        return TK_RETURN;
    }
    if (strcmp(yytext, "char")==0){
        return TK_CHAR;
    }
    if (strcmp(yytext, "print")==0){
        return TK_PRINT;
    }

    guarda_lexema();
    return TK_ID;
}

{DIGIT}+{LETRA}+    {
    guarda_lexema();
    return TK_UNDEF;
}

{DIGIT}+ {
    guarda_lexema();
    return TK_INTEGERCONST;
}

\'([^'\\\n]|\\.)\' {
    guarda_lexema();
    return TK_CHARCONST;
}

\'([^'\n]|\\.)*         {
    linha_atual++;
    return TK_UNDEF;
}

\"([^"\\\n]|\\.)*\" {
    guarda_lexema();
    return TK_STRINGCONST;
}

\"[^"\n]*\n         {
    linha_atual++;
    return TK_UNDEF;
}

"=="                { return TK_EQ; }
"="                 { return TK_ASSIGN; }
"!=" {return TK_NEQ;}
"!" {return TK_NOT;}
"<=" {return TK_LEQ;}
"<" {return TK_LT;}
">=" {return TK_GEQ;}
">" {return TK_GT;}
"&&" {return TK_AND;}
"||" {return TK_OR;}

 /* --- Operadores aritmeticos e simbolos de pontuacao (ja prontos) ------ */
"+"                 { return TK_PLUS; }
"-"                 { return TK_MINUS; }
"*"                 { return TK_MUL; }
"/"                 { return TK_DIV; }
"%"                 { return TK_MOD; }
";"                 { return TK_SEMICOLON; }
","                 { return TK_COMMA; }
"("                 { return TK_LPAREN; }
")"                 { return TK_RPAREN; }
"{"                 { return TK_LBRACE; }
"}"                 { return TK_RBRACE; }
"["                 { return TK_LBRACKET; }
"]"                 { return TK_RBRACKET; }

.                   {
                        microc_yylval.error_msg = strdup(yytext);
                        return TK_UNDEF;
                    }

%%

/* -----------------------------------------------------------------------
 * 4. SUB-ROTINAS DO USUARIO
 * ------------------------------------------------------------------- */

/* yywrap: informa ao flex que, ao atingir o EOF, a leitura deve
 * simplesmente parar (nao ha um proximo arquivo a processar). */
int yywrap(void) {
    return 1;
}

/* main() de teste: le o arquivo passado como argumento e imprime, para
 * cada token reconhecido, seu tipo, lexema e linha -- no mesmo espirito
 * do utilitario "lexer" mencionado no enunciado (Secao 6). Este main()
 * e apenas uma ferramenta de depuracao para voce testar seu scanner de
 * forma isolada; ele NAO faz parte da interface formal entre o scanner
 * e o parser (isso sera tratado nos trabalhos seguintes). */
int main(int argc, char **argv) {
    if (argc < 2) {
        fprintf(stderr, "Uso: %s <arquivo.mc>\n", argv[0]);
        return 1;
    }

    FILE *arquivo_fonte = fopen(argv[1], "r");
    if (!arquivo_fonte) {
        fprintf(stderr, "Erro: nao foi possivel abrir o arquivo '%s'\n", argv[1]);
        return 1;
    }
    yyin = arquivo_fonte;

    int tipo;
    while ((tipo = yylex()) != TK_END_OF_FILE) {
        if (tipo == TK_UNDEF) {
            fprintf(stderr, "(ERRO LEXICO (linha %d coluna %d): %s) \n",
                    linha_atual,coluna_atual, microc_yylval.error_msg);
            continue;
        }
        printf("Token: tipo = %-13s lexema = '%s'  linha = %d\n",
                nome_token[tipo], yytext, linha_atual);
    }
    printf("Token: tipo = %-13s lexema = '%s'  linha = %d\n",
               nome_token[tipo], yytext, linha_atual);

    fclose(arquivo_fonte);
    return 0;
}
