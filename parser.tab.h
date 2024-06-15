/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_PARSER_TAB_H_INCLUDED
# define YY_YY_PARSER_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    T_PUBLIC = 258,                /* T_PUBLIC  */
    T_PRIVATE = 259,               /* T_PRIVATE  */
    T_CHAR = 260,                  /* T_CHAR  */
    T_CLASS = 261,                 /* T_CLASS  */
    T_INT = 262,                   /* T_INT  */
    T_DOUBLE = 263,                /* T_DOUBLE  */
    T_BOOLEAN = 264,               /* T_BOOLEAN  */
    T_STRING = 265,                /* T_STRING  */
    T_NEW = 266,                   /* T_NEW  */
    T_RETURN = 267,                /* T_RETURN  */
    T_VOID = 268,                  /* T_VOID  */
    T_IF = 269,                    /* T_IF  */
    T_ELSE = 270,                  /* T_ELSE  */
    T_WHILE = 271,                 /* T_WHILE  */
    T_DO = 272,                    /* T_DO  */
    T_FOR = 273,                   /* T_FOR  */
    T_SWITCH = 274,                /* T_SWITCH  */
    T_CASE = 275,                  /* T_CASE  */
    T_DEFAULT = 276,               /* T_DEFAULT  */
    T_BREAK = 277,                 /* T_BREAK  */
    T_TRUE = 278,                  /* T_TRUE  */
    T_FALSE = 279,                 /* T_FALSE  */
    T_OUTPRINT = 280,              /* T_OUTPRINT  */
    T_OUTPRINTLN = 281,            /* T_OUTPRINTLN  */
    T_SIZEOP = 282,                /* T_SIZEOP  */
    T_ID = 283,                    /* T_ID  */
    T_CCONST = 284,                /* T_CCONST  */
    T_OROP = 285,                  /* T_OROP  */
    T_ANDOP = 286,                 /* T_ANDOP  */
    T_EQUOP = 287,                 /* T_EQUOP  */
    T_RELOP = 288,                 /* T_RELOP  */
    T_ADDOP = 289,                 /* T_ADDOP  */
    T_MULOP = 290,                 /* T_MULOP  */
    T_NOTOP = 291,                 /* T_NOTOP  */
    T_INCDEC = 292,                /* T_INCDEC  */
    T_LPAREN = 293,                /* T_LPAREN  */
    T_RPAREN = 294,                /* T_RPAREN  */
    T_SEMI = 295,                  /* T_SEMI  */
    T_COMMA = 296,                 /* T_COMMA  */
    T_ASSIGN = 297,                /* T_ASSIGN  */
    T_LBRACK = 298,                /* T_LBRACK  */
    T_RBRACK = 299,                /* T_RBRACK  */
    T_REFER = 300,                 /* T_REFER  */
    T_LBRACE = 301,                /* T_LBRACE  */
    T_RBRACE = 302,                /* T_RBRACE  */
    T_EOF = 303                    /* T_EOF  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 15 "parser.y"

    char *str;
    int num;
    double dnum;
    char chr;

#line 119 "parser.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_PARSER_TAB_H_INCLUDED  */
