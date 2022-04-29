%{
#include<stdio.h>
#include<stdlib.h>
#include "y.tab.h"
int yylex(void);
void yyerror(char *);

%}

%%
"#"[a-zA-Z][ \ta-zA-Z0-9]*"#" return COMMENT;
"disp"                  return DISPLAY;
"incase"                return INCASE;
"notincase"             return NOTINCASE;
"during"                return DURING;
"fpn"                   return FPN;
"wn"                    return WN;
"ch"                    return CH;
[a-zA-Z][a-zA-Z0-9]*    {yylval.sValue = *yytext; return VARIABLE;}
"><"                    return AND;
"<>"                    return OR;
[1-9][0-9]*             {yylval.iValue= atoi(yytext);return INTEGER;}
[0-9]*(\.)?[0-9]+       {yylval.fValue= atof(yytext);return FLOAT;}   
"+"                     return PLUS;
"-"                     return MINUS;
"*"                     return MULTI;
"/"                     return OVER;
";"                     return SEMI;
":"                     return COLON;
"<"                     return LES;
">"                     return BIG;
"<="                    return LESEQ;
">="                    return BIGEQ;
"?="                    return ISEQ;
"("                     return LPAR;
")"                     return RPAR;
"~"                     return NOT;
"->"                    return ASSIGN;
":>"                    return END;
"<:"                    return START;
[ \t\n]+                ;
.                       ;   

%%



int yywrap(void){
    return 1;
}