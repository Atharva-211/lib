%{
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

int sym[26];  // Symbol table for variables a-z
int initialized[26] = {0};  // Track which variables are defined

void yyerror(const char *s);
int yylex();
%}

%union {
    int num;
    char var;
}

%token <num> NUMBER
%token <var> VARIABLE
%token PLUS MINUS MUL DIV LPAREN RPAREN

%type <num> expr factor term

%start input

%%

input:
    input expr '\n'    { printf("= %d\n", $2); }
  | input assignment '\n'
  | /* empty */
;

assignment:
    VARIABLE '=' expr {
        sym[$1 - 'a'] = $3;
        initialized[$1 - 'a'] = 1;
        printf("%c = %d\n", $1, $3);
    }
;

expr:
    expr PLUS term     { $$ = $1 + $3; }
  | expr MINUS term    { $$ = $1 - $3; }
  | term               { $$ = $1; }
;

term:
    term MUL factor    { $$ = $1 * $3; }
  | term DIV factor    {
        if ($3 == 0) {
            yyerror("Division by zero");
            $$ = 0;
        } else {
            $$ = $1 / $3;
        }
    }
  | factor             { $$ = $1; }
;

factor:
    NUMBER             { $$ = $1; }
  | VARIABLE {
        if (!initialized[$1 - 'a']) {
            char msg[50];
            snprintf(msg, sizeof(msg), "Variable '%c' not initialized", $1);
            yyerror(msg);
            $$ = 0;
        } else {
            $$ = sym[$1 - 'a'];
        }
    }
  | LPAREN expr RPAREN { $$ = $2; }
;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Enter expressions or assignments (e.g., a = 5 + 3):\n");
    yyparse();
    return 0;
}
