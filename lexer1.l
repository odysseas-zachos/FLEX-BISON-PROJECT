%{

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <math.h>
#include <string.h>
#include "parser.tab.h"

int lineno = 1;
int error_count = 0;


%}

%option yylineno
%option noyywrap

LETTER      [a-zA-Z]
DIGIT       [0-9]
CHARACTER   {LETTER}|{DIGIT}
NZNUMBER    [1-9]{DIGIT}*|0    /*AKERAIOS ARITHMOS */ 

ID          _?{LETTER}({LETTER}|{DIGIT}|_)*
ICONST      {NZNUMBER}
FCONST      {NZNUMBER}\.{DIGIT}*
CCONST      \'.\'
WHITESPACE  [ \t]


%%
"public"         	{ printf("\nKEYWORD -> char\n"); return T_PUBLIC; } 
"private"        	{ printf("\nKEYWORD -> private\n"); return T_PRIVATE; }
"class"          	{ printf("\nKEYWORD -> class\n"); return T_CLASS; }
"int"            	{ printf("\nKEYWORD -> int\n"); return T_INT; }
"char"           	{ printf("\nKEYWORD -> char\n"); return T_CHAR; }
"double"         	{ printf("\nKEYWORD -> double\n"); return T_DOUBLE; }
"boolean"        	{ printf("\nKEYWORD -> boolean\n"); return T_BOOLEAN; } 
"String"         	{ printf("\nKEYWORD -> String\n"); return T_STRING; } 
"new"            	{ printf("\nKEYWORD -> new\n"); return T_NEW; }
"return"         	{ printf("\nKEYWORD -> return\n"); return T_RETURN; }
"void"           	{ printf("\nKEYWORD -> void\n"); return T_VOID; }
"if"             	{ printf("\nKEYWORD -> if\n"); return T_IF; }
"else"           	{ printf("\nKEYWORD -> else\n"); return T_ELSE; }
"while"          	{ printf("\nKEYWORD -> while\n"); return T_WHILE; }
"do"             	{ printf("\nKEYWORD -> do\n"); return T_DO; }
"for"            	{ printf("\nKEYWORD -> for\n"); return T_FOR; }
"switch"         	{ printf("\nKEYWORD -> switch\n"); return T_SWITCH; }
"case"           	{ printf("\nKEYWORD -> case\n"); return T_CASE; }
"default"        	{ printf("\nKEYWORD -> default\n"); return T_DEFAULT; }
"break"          	{ printf("\nKEYWORD -> break\n"); return T_BREAK; }
"true"           	{ printf("\nKEYWORD -> true\n"); return T_TRUE; }
"false"          	{ printf("\nKEYWORD -> false\n"); return T_FALSE; }
"out.print"      	{ printf("\nKEYWORD -> outprint\n"); return T_OUTPRINT; }
"out.println"    	{ printf("\nKEYWORD -> outprintln\n"); return T_OUTPRINTLN; }

"sizeof"                { printf("\nSIZEOP\n"); return T_SIZEOP; }

{ID}                { printf("\nID -> %s\n", yytext); return T_ID; }

{CCONST}            { printf("\nCCONST -> %s\n", yytext); return T_CCONST; }


{WHITESPACE}        { /* Κενά (space) μέσα στο αρχείο - απλά τα αγνοούμε */ }
\n                  { lineno++; /* Εναλλακτικά βασιζόμαστε στο Flex να αυξήσει την μεταβλητή 'yylineno' κατά 1 ΑΥΤΟΜΑΤΑ */ }
<<EOF>>             { printf("\nEOF\n"); return T_EOF; }
.                   { error_count++; printf("\nUnrecognised character at line %d!\n", yylineno); }


%%

