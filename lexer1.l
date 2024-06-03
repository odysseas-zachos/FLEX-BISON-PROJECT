%{
#include "parser1.tab.h"
%}

%%
"public"        return PUBLIC;
"class"         return CLASS;
"int"           return INT;
"char"          return CHAR;
"double"        return DOUBLE;
"boolean"       return BOOLEAN;
"String"        return STRING;
"void"          return VOID;
"if"            return IF;
"else"          return ELSE;
"while"         return WHILE;
"do"            return DO;
"for"           return FOR;
"return"        return RETURN;
"break"         return BREAK;
"new"           return NEW;
"true"          return TRUE;
"false"         return FALSE;
"out.print"     return OUT_PRINT;
"{"             return '{';
"}"             return '}';
"("             return '(';
")"             return ')';
";"             return ';';
","             return ',';
"="             return '=';
"=="            return EQUAL;
"!="            return NOT_EQUAL;
">"             return '>';
"<"             return '<';
"+"             return '+';
"-"             return '-';
"*"             return '*';
"/"             return '/';
"&&"            return AND;
"||"            return OR;
\"[^\"]*\"      { yylval.string = strdup(yytext); return STRING_LITERAL; }
\'[^\']\'       { yylval.char_val = yytext[1]; return CHAR_LITERAL; }
[0-9]+"d"       { yylval.double_val = atof(yytext); return DOUBLE_LITERAL; }
[0-9]+          { yylval.int_val = atoi(yytext); return INT_LITERAL; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval.string = strdup(yytext); return IDENTIFIER; }
[ \t\n]+        /* Ignore whitespace */
.               { printf("Unexpected character: %s\n", yytext); return ERROR; }
%%
