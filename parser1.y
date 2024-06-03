%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
int yylex(void);
extern FILE *yyin;

%}

%union {
    char *string;
    int int_val;
    double double_val;
    char char_val;
}

%token <string> IDENTIFIER STRING_LITERAL
%token <int_val> INT_LITERAL
%token <double_val> DOUBLE_LITERAL
%token <char_val> CHAR_LITERAL

%token PUBLIC PRIVATE CLASS INT CHAR DOUBLE BOOLEAN STRING VOID IF ELSE WHILE DO FOR RETURN BREAK NEW TRUE FALSE OUT_PRINT

%token EQUAL NOT_EQUAL AND OR ERROR

%left '+' '-'
%left '*' '/'

%%
program: class_list
       ;

class_list: class
          | class_list class
          ;

class: PUBLIC CLASS IDENTIFIER '{' class_body '}'
     ;

class_body: variable_declaration_list method_declaration_list
          ;

variable_declaration_list: /* empty */
                         | variable_declaration_list variable_declaration
                         ;

variable_declaration: type IDENTIFIER ';'
                    | type IDENTIFIER '=' expression ';'
                    | type IDENTIFIER_LIST ';'
                    ;

IDENTIFIER_LIST: IDENTIFIER
               | IDENTIFIER_LIST ',' IDENTIFIER
               ;

method_declaration_list: /* empty */
                       | method_declaration_list method_declaration
                       ;

method_declaration: PUBLIC type IDENTIFIER '(' parameter_list ')' '{' method_body '}'
                  | PRIVATE type IDENTIFIER '(' parameter_list ')' '{' method_body '}'
                  | PUBLIC VOID IDENTIFIER '(' parameter_list ')' '{' method_body '}'
                  | PRIVATE VOID IDENTIFIER '(' parameter_list ')' '{' method_body '}'
                  ;

parameter_list: /* empty */
              | parameter
              | parameter_list ',' parameter
              ;

parameter: type IDENTIFIER
         ;

method_body: variable_declaration_list statement_list
           ;

statement_list: /* empty */
              | statement_list statement
              ;

statement: assignment
         | loop
         | conditional
         | print
         | return_stmt
         | break_stmt
         ;

assignment: IDENTIFIER '=' expression ';'
          ;

loop: do_while
    | for_loop
    ;

do_while: DO '{' statement_list '}' WHILE '(' expression ')' ';'
        ;

for_loop: FOR '(' assignment expression ';' assignment ')' '{' statement_list '}'
        ;

conditional: IF '(' expression ')' '{' statement_list '}' else_if_list else_block
           ;

else_if_list: /* empty */
            | else_if_list ELSE IF '(' expression ')' '{' statement_list '}'
            ;

else_block: /* empty */
          | ELSE '{' statement_list '}'
          ;

print: OUT_PRINT '(' STRING_LITERAL opt_comma_identifier ')' ';'
     ;

opt_comma_identifier: /* empty */
                    | ',' IDENTIFIER
                    ;

return_stmt: RETURN expression ';'
           | RETURN ';'
           ;

break_stmt: BREAK ';'
          ;

expression: literal
          | IDENTIFIER
          | method_call
          | new_object
          | '(' expression ')'
          | expression '+' expression
          | expression '-' expression
          | expression '*' expression
          | expression '/' expression
          | expression '>' expression
          | expression '<' expression
          | expression EQUAL expression
          | expression NOT_EQUAL expression
          | expression AND expression
          | expression OR expression
          ;

method_call: IDENTIFIER '(' argument_list ')'
           ;

argument_list: /* empty */
             | expression
             | argument_list ',' expression
             ;

new_object: NEW IDENTIFIER '(' ')'
          ;

literal: INT_LITERAL
       | CHAR_LITERAL
       | DOUBLE_LITERAL
       | TRUE
       | FALSE
       | STRING_LITERAL
       ;

type: INT
    | CHAR
    | DOUBLE
    | BOOLEAN
    | STRING
    | IDENTIFIER
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(int argc, char **argv) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <filename>\n", argv[0]);
        return 1;
    }

    FILE *file = fopen(argv[1], "r");
    if (!file) {
        perror(argv[1]);
        return 1;
    }

    yyin = file;
    yyparse();

    fclose(file);
    return 0;
}
