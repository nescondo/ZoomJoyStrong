%{
#include "calc.tab.h"   // Bison header
#include <stdio.h>
%}
 
%%
[0-9]+       { yylval.num = atof(yytext); return NUMBER; }
end	         { return END; }
=            { return EQUALS; }
\+           { return PLUS; }
-            { return MINUS; }
\*           { return MULT; }
\/           { return DIV; }
\(           { return LEFT_PAREN; }
\)           { return RIGHT_PAREN; }
;	         { return SEMI; }
\$[A-Z]	     { yylval.var = yytext[1] - 65; return VARIABLE; }
[ \r\t\n]+   ;   // ignore whitespace
.            { printf("Unknown character: %s\n", yytext); }
%%
 
int yywrap(void) {
    return 1;
}
