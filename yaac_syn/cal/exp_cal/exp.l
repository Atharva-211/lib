%{
#include "exp.tab.h"
#include <ctype.h>
%}

%%

[ \t\n]+           ;                     // Ignore whitespace
[0-9]+             { yylval.num = atoi(yytext); return NUMBER; }
[a-zA-Z]           { yylval.var = yytext[0]; return VARIABLE; }

"="                return '=';     // ✅ Add this line
"+"                return PLUS;
"-"                return MINUS;
"*"                return MUL;
"/"                return DIV;
"("                return LPAREN;
")"                return RPAREN;

.                  { printf("Unknown character: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}
