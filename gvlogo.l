%{
#include <stdio.h>
#include <stdlib.h>
#include "gvlogo.tab.h"

extern void yyerror(const char* s);
%}

%%

penup                     { return PENUP; }
pendown                   { return PENDOWN; }
color                     { return COLOR; }
move                      { return MOVE; }
save                      { return SAVE; }
print                     { return PRINT; }
end                       { return END; }

[0-9]+                    { yylval.f = atof(yytext); return NUMBER; }
[ \"\t\r\n]			;
[A-Z]*[a-z]*\s*           { yylval.s = yytext; return STRING; }
\;                        { return SEP; }
.			              { yyerror("Lexing Syntax error.\n"); } 

%%
