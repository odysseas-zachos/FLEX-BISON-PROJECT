%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


int yylex();
void yyerror(const char *s);
extern char* yytext;
extern int yylineno;
extern FILE *yyin;
extern FILE *yyout;
%}

%union {
    char *str;
    int num;
    double dnum;
    char chr;
}

%token T_PUBLIC
%token T_PRIVATE
%token T_CHAR
%token T_CLASS
%token T_INT
%token T_DOUBLE
%token T_BOOLEAN
%token T_STRING
%token T_NEW
%token T_RETURN
%token T_VOID
%token T_IF
%token T_ELSE
%token T_WHILE
%token T_DO
%token T_FOR
%token T_SWITCH
%token T_CASE
%token T_DEFAULT
%token T_BREAK
%token T_TRUE
%token T_FALSE
%token T_OUTPRINT
%token T_OUTPRINTLN
%token T_SIZEOP
%token T_ID
%token T_CCONST
%token T_EOF

'||' 
'&&'
'=='
'!='
'>'
'>='
'<'
'<='
'+'
'-'
'*'
'/'
'%'
'!'
'++'
'--'
'('
')'
';'
','
'='
'['
']'
'&'
'{'
'}'




%start program

%%

program:
    class_declaration;

class_declaration:
    T_PUBLIC T_CLASS T_ID '{' class_body '}' | T_PRIVATE T_CLASS T_ID '{' class_body '}' ;

class_body:
    class_body declaration | declaration ;

declaration:
    variable_declaration | method_declaration ;

variable_declaration:
    type T_ID ';' ;

type:
    T_INT | T_CHAR | T_DOUBLE | T_BOOLEAN | T_STRING ;

method_declaration:
    T_PUBLIC T_VOID T_ID '(' parameter_list ')' '{' method_body '}' | T_PUBLIC type T_ID '(' parameter_list ')' '{' method_body '}' ;

parameter_list:
     %empty | parameter_list_non_empty                     {} ;

parameter_list_non_empty:
    type T_ID | parameter_list_non_empty ',' type T_ID ;

method_body:
    statement_list ;

statement_list:
    statement_list statement | statement ;

statement:
    variable_declaration | expression_statement | compound_statement | selection_statement | iteration_statement | jump_statement ;

expression_statement:
    expression ';' ;

compound_statement:
    '{' statement_list '}' ;

selection_statement:
    T_IF '(' expression ')' statement | T_IF '(' expression ')' statement T_ELSE statement ;

iteration_statement:
    T_WHILE '(' expression ')' statement | T_DO statement T_WHILE '(' expression ')' ';' | T_FOR '(' expression_statement expression_statement ')' statement ;

jump_statement:
    T_BREAK ';' | T_RETURN expression ';' | T_RETURN ';' ;

expression:
    assignment_expression ;

assignment_expression:
    logical_or_expression | T_ID '=' assignment_expression ;

logical_or_expression:
    logical_and_expression | logical_or_expression '||' logical_and_expression ;

logical_and_expression:
    equality_expression | logical_and_expression '&&' equality_expression ;

equality_expression:
    relational_expression | equality_expression "==" relational_expression | equality_expression "!=" relational_expression ;

relational_expression:
    additive_expression | relational_expression '<' additive_expression | relational_expression '>' additive_expression ;

additive_expression:
    multiplicative_expression | additive_expression '+' multiplicative_expression | additive_expression '-' multiplicative_expression ;

multiplicative_expression:
    unary_expression | multiplicative_expression '*' unary_expression | multiplicative_expression '/' unary_expression ;

unary_expression:
    primary_expression | '!' unary_expression ;

primary_expression:
    T_ID | T_INT | T_DOUBLE | T_CHAR | T_STRING | '(' expression ')' ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

/*Main*/
int main(int argc, char* argv[]) {
	FILE *a;
	++argv; --argc;
	if (argc>0)
	{
		a = fopen(argv[0], "r");
		if (!a) {
			printf("%s error \n",argv[1]);
			exit(1);
		}
		yyin = a;
	}
	else
		yyin = stdin;
		yyout = fopen("output", "w");
		yyparse();
	return 0;
}