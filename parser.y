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
%token T_OROP
%token T_ANDOP
%token T_EQUOP
%token T_RELOP
%token T_ADDOP
%token T_MULOP
%token T_NOTOP
%token T_INCDEC
%token T_LPAREN
%token T_RPAREN
%token T_SEMI
%token T_COMMA
%token T_ASSIGN
%token T_LBRACK
%token T_RBRACK
%token T_REFER
%token T_LBRACE
%token T_RBRACE
%token T_EOF




%start program

%%

program:
    class_declaration;

class_declaration:
    T_PUBLIC T_CLASS T_ID T_LBRACE class_body T_RBRACE | T_PRIVATE T_CLASS T_ID T_LBRACE class_body T_RBRACE ;

class_body:
    class_body declaration | declaration ;

declaration:
    variable_declaration | method_declaration ;

variable_declaration:
    type T_ID T_SEMI ;

type:
    T_INT | T_CHAR | T_DOUBLE | T_BOOLEAN | T_STRING ;

method_declaration:
    T_PUBLIC T_VOID T_ID T_LPAREN parameter_list T_RPAREN T_LBRACE method_body T_RBRACE | T_PUBLIC type T_ID T_LPAREN parameter_list T_RPAREN T_LBRACE method_body T_RBRACE ;

parameter_list:
     %empty | parameter_list_non_empty                     {} ;

parameter_list_non_empty:
    type T_ID | parameter_list_non_empty T_COMMA type T_ID ;

method_body:
    statement_list ;

statement_list:
    statement_list statement | statement ;

statement:
    variable_declaration | expression_statement | compound_statement | selection_statement | iteration_statement | jump_statement ;

expression_statement:
    expression T_SEMI ;

compound_statement:
    T_LBRACE statement_list T_RBRACE ;

selection_statement:
    T_IF T_LPAREN expression T_RPAREN statement | T_IF T_LPAREN expression T_RPAREN statement T_ELSE statement ;

iteration_statement:
    T_WHILE T_LPAREN expression T_RPAREN statement | T_DO statement T_WHILE T_LPAREN expression T_RPAREN T_SEMI | T_FOR T_LPAREN expression_statement expression_statement T_RPAREN statement ;

jump_statement:
    T_BREAK T_SEMI | T_RETURN expression T_SEMI | T_RETURN T_SEMI ;

expression:
    assignment_expression ;

assignment_expression:
    logical_or_expression | T_ID T_ASSIGN assignment_expression ;

logical_or_expression:
    logical_and_expression | logical_or_expression T_OROP logical_and_expression ;

logical_and_expression:
    equality_expression | logical_and_expression T_ANDOP equality_expression ;

equality_expression:
    relational_expression | equality_expression T_EQUOP relational_expression | equality_expression T_EQUOP relational_expression ;

relational_expression:
    additive_expression | relational_expression T_EQUOP additive_expression | relational_expression T_EQUOP additive_expression ;

additive_expression:
    multiplicative_expression | additive_expression T_ADDOP multiplicative_expression | additive_expression T_ADDOP multiplicative_expression ;

multiplicative_expression:
    unary_expression | multiplicative_expression T_MULOP unary_expression | multiplicative_expression T_MULOP unary_expression ;

unary_expression:
    primary_expression | T_NOTOP unary_expression ;

primary_expression:
    T_ID | T_INT | T_DOUBLE | T_CHAR | T_STRING | method_call | T_LPAREN expression T_RPAREN ;

method_call:
    T_OUTPRINTLN T_LPAREN primary_expression T_RPAREN T_SEMI | T_OUTPRINT T_LPAREN primary_expression T_RPAREN T_SEMI ;

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