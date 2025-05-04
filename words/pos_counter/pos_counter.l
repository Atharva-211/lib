%{
/* Part of Speech Counter using Flex
 * This version reads from standard input (can be redirected from a file)
 */
#include <stdio.h>
#include <stdlib.h>

// Counters for different parts of speech
int article_count = 0;
int pronoun_count = 0;
int verb_count = 0;
int noun_count = 0;
int preposition_count = 0;
int adjective_count = 0;
int total_words = 0;

%}

/* Options */
%option noyywrap
%option case-insensitive

/* Simplified patterns for different parts of speech */
ARTICLE         a|an|the
PRONOUN         I|me|my|you|your|he|him|his|she|her|it|we|us|they|them|their|this|that|these|those
VERB            is|am|are|was|were|be|have|has|had|do|does|did|walk|walked|carry|carried|go|went|eat|run|talk|see|saw|think|make|know|take|get|come|find|give|say|said|work|feel|try|ask|need|greet|greeted|tell|told|visit|visited
NOUN            boy|girl|man|woman|teacher|student|school|book|books|house|car|dog|cat|tree|city|friend|family|home|work|time|day|year|name|people|world|room|hand|part|eye|head|door|face|body|water|air|food|school|backpack|smile|museum|history|weekend
PREPOSITION     in|on|at|by|with|from|to|for|of|about|under|over|through|between|among|before|after|during|within|without
ADJECTIVE       big|small|good|bad|young|old|new|large|little|high|low|happy|sad|hot|cold|fast|slow|hard|soft|long|short|early|warm|heavy

/* Other words */
WORD            [a-zA-Z]+

/* Whitespace and punctuation */
WHITESPACE      [ \t\n\r]
PUNCTUATION     [.,;:!?()[\]{}]

%%

{ARTICLE}       { article_count++; total_words++; printf("ARTICLE: %s\n", yytext); }
{PRONOUN}       { pronoun_count++; total_words++; printf("PRONOUN: %s\n", yytext); }
{VERB}          { verb_count++; total_words++; printf("VERB: %s\n", yytext); }
{NOUN}          { noun_count++; total_words++; printf("NOUN: %s\n", yytext); }
{PREPOSITION}   { preposition_count++; total_words++; printf("PREPOSITION: %s\n", yytext); }
{ADJECTIVE}     { adjective_count++; total_words++; printf("ADJECTIVE: %s\n", yytext); }
{WORD}          { total_words++; printf("OTHER: %s\n", yytext); }
{WHITESPACE}    { /* ignore whitespace */ }
{PUNCTUATION}   { /* ignore punctuation */ }
.               { /* ignore other characters */ }

%%

int main() {
    // Input will come from stdin (can be redirected from a file)
    // No need to change yyin as it defaults to stdin
    
    // Process input
    yylex();
    
    // Print statistics
    printf("\n--- WORD COUNT STATISTICS ---\n");
    printf("Articles: %d\n", article_count);
    printf("Pronouns: %d\n", pronoun_count);
    printf("Verbs: %d\n", verb_count);
    printf("Nouns: %d\n", noun_count);
    printf("Prepositions: %d\n", preposition_count);
    printf("Adjectives: %d\n", adjective_count);
    printf("Total recognized words: %d\n", article_count + pronoun_count + verb_count + noun_count + preposition_count + adjective_count);
    printf("Total words: %d\n", total_words);
    
    return 0;
}