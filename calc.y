%{
#include <stdio.h>
#include <stdlib.h>
 
int yylex(void);
void yyerror(const char *s);
double symbol_table[26];
%}
 
%union {
	double num;
	char var;
}
 
%token <num> NUMBER
%token <var> VARIABLE
%type <num> expr
%token EQUALS PLUS MINUS MULT DIV LEFT_PAREN RIGHT_PAREN SEMI END
%left PLUS MINUS
%left MULT DIV
%left UMINUS
%%
 
program: statement_list END		         { printf("Thanks!\n"); return 0; }
;
 
statement_list: statement
    |  statement statement_list
;
 
statement:
      assignment SEMI
    | expr SEMI                          { printf("= %f\n", $1); }
;
 
assignment:
      VARIABLE EQUALS expr               { symbol_table[$1] = $3; printf("Variable stored.\n"); }
;
 
expr:
      NUMBER                             { $$ = $1; }
    | VARIABLE				             { $$ = symbol_table[$1];}
    | expr PLUS expr                     { $$ = $1 + $3; }
    | expr MINUS expr                    { $$ = $1 - $3; }
    | expr MULT expr                     { $$ = $1 * $3; }
    | expr DIV expr                      { 
                                           if ($3 == 0) {
                                             yyerror("Division by zero");
                                             $$ = 0;
                                           } else {
                                             $$ = $1 / $3;
                                           }
                                         }
    | LEFT_PAREN expr RIGHT_PAREN        { $$ = $2; }
    | MINUS expr %prec UMINUS            { $$ = -$2; }
;
%%
 
void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
 
int main(void) {
    printf("Enter expressions, press Ctrl+D to quit.\n");
    return yyparse();
}
