%{

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <math.h>
#include <string.h>
#include "parser.tab.h"

%}

%option yylineno
%option noyywrap

LETTER      [a-zA-Z]
DIGIT       [0-9]
CHARACTER   {LETTER}|{DIGIT}
NZNUMBER    [1-9]{DIGIT}*|0    /*AKERAIOS ARITHMOS */ 

ID          _*{LETTER}({LETTER}|{DIGIT}|_)*      /* ANAGNORISTIKA GLOSSAS */ 
INTCONST          {NZNUMBER}       /* APLES ARITHMITIKES STATHERES */
FCONST      {NZNUMBER}\.{DIGIT}*    /* MI PROSIMASMENES PRAGMATIKES STATHERES */
CCONST      \'.\'    /* XARAKTIRES METAKSI TOY  ' */ 
WHITESPACE  [ \t]





%%

\"public\"       return PUBLIC; 
\"private\"      return PRIVATE;
\"class\"        return CLASS;
\"int\"          return INT;
\"char\"         return CHAR; 
"double"         return DOUBLE; 
"boolean"        return BOOLEAN; 
"String"         return STRING; 
"new"            return NEW; }
"return"         return RETURN; }
"void"           return VOID; }
"if"             return IF; }
"else"           return ELSE; }
"while"          return WHILE; }
"do"             return DO; }
"for"            return FOR; }
"switch"         return SWITCH; }
"case"           return CASE; }
"default"        return DEFAULT; }
"break"          return BREAK; }
"true"           return TRUE; }
"false"          return FALSE; }
"out.print"      return OUT_PRINT; }
"out.println"    return OUT_PRINTLN; }
[a-zA-Z_][a-zA-Z0-9_]*  return IDENTIFIER; 
[0-9]+          { printf("TOKEN: NUMBER (%s)\n", yytext); yylval.num = atoi(yytext); return NUMBER; }
[0-9]+\.[0-9]+  { printf("TOKEN: DOUBLE_NUM (%s)\n", yytext); yylval.dnum = atof(yytext); return DOUBLE_NUM; }
\'[^\']\'       { printf("TOKEN: CHARACTER (%s)\n", yytext); yylval.chr = yytext[1]; return CHARACTER; }
\"[^\"]*\"      { printf("TOKEN: STRING_LITERAL (%s)\n", yytext); yylval.str = strdup(yytext); return STRING_LITERAL; }
"=="            { printf("TOKEN: EQ\n"); return EQ; }
"!="            { printf("TOKEN: NEQ\n"); return NEQ; }
"&&"            { printf("TOKEN: AND\n"); return AND; }
"||"            { printf("TOKEN: OR\n"); return OR; }
"!"             { printf("TOKEN: !\n"); return '!'; }
"="             { printf("TOKEN: =\n"); return '='; }
"{"             { printf("TOKEN: {\n"); return '{'; }
"}"             { printf("TOKEN: }\n"); return '}'; }
";"             { printf("TOKEN: ;\n"); return ';'; }
"("             { printf("TOKEN: (\n"); return '('; }
")"             { printf("TOKEN: )\n"); return ')'; }
"+"             { printf("TOKEN: +\n"); return '+'; }
"-"             { printf("TOKEN: -\n"); return '-'; }
"*"             { printf("TOKEN: *\n"); return '*'; }
"/"             { printf("TOKEN: /\n"); return '/'; }
"<"             { printf("TOKEN: <\n"); return '<'; }
">"             { printf("TOKEN: >\n"); return '>'; }
[ \t\n]+        { /* skip whitespace */ }
"//".*          { /* skip single-line comments */ }
.               { printf("Unknown character: %s\n", yytext); yyerror("Unknown character"); }

%%

int yywrap() {
    return 1;
}
