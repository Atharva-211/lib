bison -d english.y 
flex english.l 
gcc lex.yy.c english.tab.c -o eng_parser
./eng_parser

%{
#include "english.tab.h"
%}

%%

the|a|an		{ return ARTICLE; }
cat|dog|fish|boy|girl   { return NOUN; }
eats|plays|runs|jumps|swims	{ return VERB; } 
big|small|happy|sad 	{ return ADJ; }

[ \t\n]+		;
.			{ return yytext[0]; }

%%
int yywrap() {
    return 1;  // Indicates end of input
}
