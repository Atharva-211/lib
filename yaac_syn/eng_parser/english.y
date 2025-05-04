bison -d english.y 
flex english.l 
gcc lex.yy.c english.tab.c -o eng_parser
./eng_parser


%{
#include<stdio.h>
void yyerror(const char* s);
int yylex();
%}

%token ARTICLE NOUN VERB ADJ

%%

sentence:
	 ARTICLE NOUN VERB		{printf("Valid Sentence\n");}
       | ARTICLE ADJ NOUN VERB          {printf("Valid Sentence with Adjective\n");}
       ;
%%

void yyerror(const char* s){
	printf("Syntax Error: %s\n", s);
}

int main() {
     printf("Enter a sentence:\n");
     yyparse();
     return 0;
}
	
	