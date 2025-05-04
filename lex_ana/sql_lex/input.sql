-- flex input.l
-- gcc lex.yy.c -o lexer
-- ./lexer < input.sql

SELECT name FROM employees WHERE department = 'HR';
INSERT INTO logs VALUES (1, 'entry');
