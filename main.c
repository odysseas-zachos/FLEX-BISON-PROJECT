#include <stdio.h>
#include "parser.tab.h"

extern FILE *yyin;
extern int yyparse();

int main(int argc, char **argv) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s <input file>\n", argv[0]);
        return 1;
    }

    yyin = fopen(argv[1], "r");
    if (!yyin) {
        perror(argv[1]);
        return 1;
    }

    if (yyparse() == 0) {
        printf("The program is syntactically correct.\n");
    } else {
        printf("The program has syntax errors.\n");
    }

    fclose(yyin);
    return 0;
}