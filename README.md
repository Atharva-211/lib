# lib
%{
#include <stdio.h>

int printf_count = 0, scanf_count = 0;
%}

%%
"printf"        { printf_count++; }
"scanf"         { scanf_count++; }
.|\n            ; // Ignore everything else
%%

int main() {
    printf("Paste your C code and press Ctrl+D (Linux/Mac) or Ctrl+Z (Windows) to end input:\n");
    yylex();
    printf("\nNumber of printf: %d\n", printf_count);
    printf("Number of scanf: %d\n", scanf_count);
    return 0;
}

int yywrap() {
    return 1;
}
