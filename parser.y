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
%token T_STRING_LITERAL
%token T_NZNUMBER
%token T_DOT

%start program

%%

program:  /* ALLAGI */
    class_declaration | class_declaration class_declaration | class_declaration class_declaration class_declaration | class_declaration class_declaration class_declaration class_declaration | class_declaration class_declaration class_declaration class_declaration class_declaration | class_declaration class_declaration class_declaration class_declaration class_declaration class_declaration | class_declaration class_declaration class_declaration class_declaration class_declaration class_declaration class_declaration | class_declaration class_declaration class_declaration class_declaration class_declaration class_declaration class_declaration class_declaration | class_declaration class_declaration class_declaration class_declaration class_declaration class_declaration class_declaration class_declaration class_declaration | class_declaration class_declaration class_declaration class_declaration class_declaration class_declaration class_declaration class_declaration class_declaration class_declaration ;

class_declaration:
    T_PUBLIC T_CLASS T_ID T_LBRACE class_body T_RBRACE | T_PRIVATE T_CLASS T_ID T_LBRACE class_body T_RBRACE | T_PUBLIC T_CLASS T_ID T_LBRACE class_body class_declaration T_RBRACE  ;


class_body:
    class_body declaration | declaration ;

declaration:
    variable_declaration | method_declaration ;

variable_declaration:
    type T_ID T_SEMI | type T_ID T_ASSIGN expression T_SEMI | type T_ID T_RELOP expression T_SEMI | T_ID T_ID T_ASSIGN object_creation T_SEMI | modifier type T_ID T_SEMI | modifier type T_ID T_ASSIGN T_STRING_LITERAL T_SEMI ;

type:
    T_INT | T_CHAR | T_DOUBLE | T_BOOLEAN | T_STRING | type T_LBRACK T_RBRACK;

modifier: /* ALLAGI */ 
    T_PRIVATE ;

method_declaration:
    T_PUBLIC T_VOID T_ID T_LPAREN parameter_list T_RPAREN T_LBRACE method_body T_RBRACE | T_PUBLIC type T_ID T_LPAREN parameter_list T_RPAREN T_LBRACE method_body T_RBRACE ;

parameter_list:
     %empty | parameter_list_non_empty                     {} ;

parameter_list_non_empty:
    type T_ID | parameter_list_non_empty T_COMMA type T_ID ;

method_body:
    statement_list ;

statement_list:
    statement_list statement | statement | statement iteration_statement | statement_list iteration_statement ;

statement:
    variable_declaration | expression_statement | compound_statement | selection_statement | iteration_statement | jump_statement | method_call | method_declaration | expression_statement iteration_statement ;

expression_statement:
    expression T_SEMI | expression ;

compound_statement:
    T_LBRACE statement_list T_RBRACE ;

selection_statement:
    T_IF T_LPAREN expression T_RPAREN statement | T_IF T_LPAREN expression T_RPAREN statement T_ELSE statement ;

iteration_statement:
    T_WHILE T_LPAREN expression T_RPAREN statement | T_DO statement T_WHILE T_LPAREN expression T_RPAREN T_SEMI | T_FOR T_LPAREN expression_statement expression_statement T_RPAREN statement 
    | T_FOR T_LPAREN expression_statement expression_statement expression_statement T_RPAREN iteration_block ;

iteration_block:
    statement
    | compound_statement /* Handle { ... } block */
    ;

jump_statement:
    T_BREAK T_SEMI | T_RETURN expression T_SEMI | T_RETURN T_SEMI ;

expression:
    assignment_expression  | additive_expression | primary_expression ;

assignment_expression:
    logical_or_expression | T_ID T_ASSIGN assignment_expression | T_ID T_ASSIGN logical_or_expression | additive_expression ;

logical_or_expression:
    logical_and_expression | logical_or_expression T_OROP logical_and_expression ;

logical_and_expression:
    equality_expression | logical_and_expression T_ANDOP equality_expression ;

equality_expression:
    relational_expression | equality_expression T_EQUOP relational_expression | equality_expression T_EQUOP relational_expression  ;

relational_expression:
    additive_expression | relational_expression T_RELOP additive_expression | relational_expression T_RELOP additive_expression ;

additive_expression:
    multiplicative_expression | additive_expression T_ADDOP multiplicative_expression | additive_expression T_ADDOP multiplicative_expression ;

multiplicative_expression:
    unary_expression | multiplicative_expression T_MULOP unary_expression | multiplicative_expression T_MULOP unary_expression ;

unary_expression:
    primary_expression | T_NOTOP unary_expression ;

primary_expression:
    T_ID | T_INT | T_DOUBLE | T_CHAR | T_STRING_LITERAL | T_NZNUMBER | method_call | T_LPAREN expression T_RPAREN | T_LPAREN type T_RPAREN primary_expression | object_creation | T_INCDEC ;

object_creation:
    T_NEW T_ID T_LPAREN T_RPAREN | T_NEW T_ID T_LPAREN argument_list T_RPAREN; 

argument_list:
    expression 
    | argument_list T_COMMA expression;

method_call:
    T_OUTPRINTLN T_LPAREN primary_expression T_RPAREN T_SEMI | T_OUTPRINT T_LPAREN primary_expression T_RPAREN T_SEMI | T_OUTPRINTLN T_LPAREN primary_expression T_COMMA T_ID T_RPAREN T_SEMI | T_OUTPRINTLN T_LPAREN primary_expression T_COMMA T_STRING_LITERAL T_RPAREN T_SEMI | T_ID T_DOT T_ID T_LPAREN T_RPAREN T_SEMI 
    | T_ID T_DOT T_ID T_LPAREN argument_list T_RPAREN T_SEMI; 

%%

void yyerror(const char *s) {
    if (s != NULL) {
        fprintf(stderr, "Error: %s at line %d\n", s, yylineno);
    }
    else {
        fprintf(stderr, "The input is correct");
    }
}

/*Main*/
int main(int argc, char* argv[]) {
    FILE *input;

    // Check if an input file argument is provided
    if (argc > 1) {
        input = fopen(argv[1], "r");
        if (!input) {
            fprintf(stderr, "Error opening file: %s\n", argv[1]);
            exit(EXIT_FAILURE);
        }
    } else {
        fprintf(stderr, "Usage: %s <input>\n", argv[0]);
        exit(EXIT_FAILURE);
    }

    // Print the contents of input.txt to the screen
    int c;
    while ((c = fgetc(input)) != EOF) {
        putchar(c);
    }

    // Set yyin to read from the input file
    yyin = input;

    // Close the input file after reading
    fclose(input);

    
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
	else {
        yyin = stdin;
    }
    yyout = fopen("output", "w");
    yyparse();
    fclose(yyout);
    fclose(yyin);
    return 0;
}