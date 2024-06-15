%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
int yylex(void);
%}

%union {
    char *str;
    int num;
    double dnum;
    char chr;
}

%token PUBLIC PRIVATE CLASS INT CHAR DOUBLE BOOLEAN STRING NEW RETURN VOID IF ELSE WHILE DO FOR SWITCH CASE DEFAULT BREAK TRUE FALSE OUT_PRINT OUT_PRINTLN
%token <str> IDENTIFIER STRING_LITERAL
%token <num> NUMBER
%token <dnum> DOUBLE_NUM
%token <chr> CHARACTER
%token EQ NEQ AND OR

%start program

%%

program:
    class_declaration
    ;

class_declaration:
    PUBLIC CLASS IDENTIFIER '{' class_body '}'
    | PRIVATE CLASS IDENTIFIER '{' class_body '}'
    ;

class_body:
    class_body declaration
    | declaration
    ;

declaration:
    variable_declaration
    | method_declaration
    ;

variable_declaration:
    type IDENTIFIER ';'
    ;

type:
    INT
    | CHAR
    | DOUBLE
    | BOOLEAN
    | STRING
    ;

method_declaration:
    PUBLIC VOID IDENTIFIER '(' parameter_list ')' '{' method_body '}'
    | PUBLIC type IDENTIFIER '(' parameter_list ')' '{' method_body '}'
    ;

parameter_list:
    /* empty */
    | parameter_list_non_empty
    ;

parameter_list_non_empty:
    type IDENTIFIER
    | parameter_list_non_empty ',' type IDENTIFIER
    ;

method_body:
    statement_list
    ;

statement_list:
    statement_list statement
    | statement
    ;

statement:
    variable_declaration
    | expression_statement
    | compound_statement
    | selection_statement
    | iteration_statement
    | jump_statement
    ;

expression_statement:
    expression ';'
    ;

compound_statement:
    '{' statement_list '}'
    ;

selection_statement:
    IF '(' expression ')' statement
    | IF '(' expression ')' statement ELSE statement
    ;

iteration_statement:
    WHILE '(' expression ')' statement
    | DO statement WHILE '(' expression ')' ';'
    | FOR '(' expression_statement expression_statement ')' statement
    ;

jump_statement:
    BREAK ';'
    | RETURN expression ';'
    | RETURN ';'
    ;

expression:
    assignment_expression
    ;

assignment_expression:
    logical_or_expression
    | IDENTIFIER '=' assignment_expression
    ;

logical_or_expression:
    logical_and_expression
    | logical_or_expression OR logical_and_expression
    ;

logical_and_expression:
    equality_expression
    | logical_and_expression AND equality_expression
    ;

equality_expression:
    relational_expression
    | equality_expression EQ relational_expression
    | equality_expression NEQ relational_expression
    ;

relational_expression:
    additive_expression
    | relational_expression '<' additive_expression
    | relational_expression '>' additive_expression
    ;

additive_expression:
    multiplicative_expression
    | additive_expression '+' multiplicative_expression
    | additive_expression '-' multiplicative_expression
    ;

multiplicative_expression:
    unary_expression
    | multiplicative_expression '*' unary_expression
    | multiplicative_expression '/' unary_expression
    ;

unary_expression:
    primary_expression
    | '!' unary_expression
    ;

primary_expression:
    IDENTIFIER
    | NUMBER
    | DOUBLE_NUM
    | CHARACTER
    | STRING_LITERAL
    | '(' expression ')'
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
