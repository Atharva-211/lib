%{
#include <stdio.h>
%}

%%

printf       { printf("writef"); }
scanf        { printf("readf"); }
.|\n         { ECHO; }  // Echo all other characters as-is

%%

int yywrap() {
    return 1;
}

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *fp = fopen(argv[1], "r");
        if (!fp) {
            perror("Error opening file");
            return 1;
        }
        yyin = fp;
    }

    yylex();
    return 0;
}
