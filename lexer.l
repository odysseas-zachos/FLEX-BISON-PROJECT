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

ALL_CHARS [ -!#-\[\]-~]
ESC_CHARS \\["\\bfnrt/]
LETTER      [a-zA-Z]
DIGIT       [0-9]
CHARACTER   {LETTER}|{DIGIT}
NZNUMBER    [1-9]{DIGIT}*|0   
CHAR        {ALL_CHARS}|{ESC_CHARS}|{LETTER}
ID          _?{LETTER}({LETTER}|{DIGIT}|_)*
CHARS_A     {CHAR}+
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

{NZNUMBER}          { printf("\nNZNUMBER -> %s\n", yytext); return T_NZNUMBER; }

{CCONST}            { printf("\nCCONST -> %s\n", yytext); return T_CCONST; }

"||"                { printf("\nOROP\n"); return T_OROP; }
"&&"                { printf("\nANDOP\n"); return T_ANDOP; }
"=="|"!="           { printf("\nEQUOP -> %s\n", yytext); return T_EQUOP; }
">"|">="|"<"|"<="   { printf("\nRELOP -> %s\n", yytext); return T_RELOP; }
"+"|"-"             { printf("\nADDOP -> %s\n", yytext); return T_ADDOP; }
"*"|"/"|"%"         { printf("\nMULOP -> %s\n", yytext); return T_MULOP; }
"!"                 { printf("\nNOTOP\n"); return T_NOTOP; }
"++"|"--"           { printf("\nINCDEC -> %s\n", yytext); return T_INCDEC; }

"("                 { printf("\nLPAREN\n"); return T_LPAREN; }
")"                 { printf("\nRPAREN\n"); return T_RPAREN; }
";"                 { printf("\nSEMI\n"); return T_SEMI; }
","                 { printf("\nCOMMA\n"); return T_COMMA; }

"="                 { printf("\nASSIGN\n"); return T_ASSIGN; }
"["                 { printf("\nLBRACK\n"); return T_LBRACK; }
"]"                 { printf("\nRBRACK\n"); return T_RBRACK; }
"&"                 { printf("\nREFER\n"); return T_REFER; }
"{"                 { printf("\nRBRACE\n"); return T_LBRACE; }
"}"                 { printf("\nRBRACE\n"); return T_RBRACE; }

{WHITESPACE}        { /* Κενά (space) μέσα στο αρχείο - απλά τα αγνοούμε */ }
\n                  { /* Ignore newlines */ lineno++; /* Optionally increment yylineno */ }
<<EOF>>             { printf("\nEOF\n"); return T_EOF; }
.                   { error_count++; }
\"({CHARS_A})*\"       { printf("\nSTRINGLITERAL -> %s\n", yytext); return T_STRING_LITERAL; }


%%

