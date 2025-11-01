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
clear                     { return CLEAR; }
turn                      { return TURN; }
where                     { return WHERE; }
goto                      { return GOTO; }
end                       { return END; }


\;                        { return SEP; }
[0-9]+                    { yylval.f = atof(yytext); return NUMBER; }
[ \t\r\n]			;
\"[^"']+\"                { yylval.s = yytext; return QSTRING; }
[a-zA-Z0-9_-]+\.bmp       { yylval.s = yytext; return STRING; }
[A-Z]                     { yylval.var = yytext[0] - 65; return VARIABLE; }

\+                        { return PLUS; }
\-                        { return SUB; }
\*                        { return MULT; }
\/                        { return DIV; }
\=                        { return EQUALS; }
.			              { yyerror("Lexing Syntax error.\n"); } 

%%
