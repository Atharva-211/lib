// flex while_lex.l
// bison -d while_parser.y
// gcc lex.yy.c while_parser.tab.c -o lexer
// ./lexer < test.c

// Test file with various while statements
while (x < 10) {
    x = x + 1;
}

// Error case: missing closing parenthesis
while (x < 10 {
    x = x + 1;
}

// Error case: empty condition
while () {
    x = x + 1;
}

// Error case: missing semicolon
while (x < 10) {
    x = x + 1
}

if (x > 0) {
    y = x;
} else {
    y = -x;
}

if (x > 0 {
    y = x;
}
