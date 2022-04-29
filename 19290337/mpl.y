%{
#include<stdio.h>
#include<stdlib.h>


int yylex();
void yyerror(char *s);

%}

%union {
    int iValue;
    float fValue;
    char sValue;
};

%token <iValue> INTEGER //returned by wn
%token <fValue> FLOAT   // returned by fpn
%token <sValue> CHAR
%token INCASE NOTINCASE  DURING DISPLAY COLON SEMI OR AND NOT OVER PLUS MINUS MULTI ISEQ LES BIG BIGEQ LESEQ ASSIGN LPAR RPAR START END VARIABLE COMMENT// incase notincase  during disp : . <> >< ~ / + - * ?= <  >  -> ( ) :> <: % &
%token FPN WN CH
%left ISEQ BIG LES LESEQ BIGEQ
%left PLUS MINUS
%left MULTI OVER





%%

program:
        START stmntlst  END              {return 0;}
        ;


stmntlst:
        stmntlst stmnt
        |
        ;

stmnt: 
        DISPLAY exp SEMI
        | DURING exp COLON  stmnt 
        | INCASE exp COLON stmnt COLON
        | INCASE exp COLON stmnt COLON NOTINCASE COLON stmnt COLON
        | WN VARIABLE  ASSIGN exp SEMI
        | FPN VARIABLE  ASSIGN exp SEMI
        | CH VARIABLE  ASSIGN exp SEMI
        | VARIABLE ASSIGN exp SEMI
        | VARIABLE ASSIGN PLUS exp SEMI
        | VARIABLE ASSIGN MINUS exp SEMI
        | VARIABLE ASSIGN MULTI exp SEMI
        | VARIABLE ASSIGN OVER exp SEMI
        | COMMENT
        ;   
exp:
    INTEGER
    |FLOAT                  
    |CHAR
    |exp PLUS INTEGER
    |exp MINUS INTEGER
    |exp MULTI INTEGER
    |exp OVER INTEGER
    |exp PLUS FLOAT
    |exp MINUS FLOAT
    |exp MULTI FLOAT
    |exp OVER FLOAT
    |exp PLUS VARIABLE
    |exp MINUS VARIABLE
    |exp MULTI VARIABLE
    |exp OVER VARIABLE
    |VARIABLE
    |comp
    |LPAR exp RPAR
    |exp OR INTEGER
    |exp OR FLOAT
    |exp OR VARIABLE
    |exp AND INTEGER
    |exp AND FLOAT
    |exp AND VARIABLE
    |NOT INTEGER
    |NOT FLOAT
    |NOT VARIABLE
    ;



comp:
        INTEGER ISEQ INTEGER
        |INTEGER BIG INTEGER
        |INTEGER LES INTEGER
        |INTEGER BIGEQ INTEGER
        |INTEGER LESEQ INTEGER
        
        |FLOAT ISEQ FLOAT
        |FLOAT BIG FLOAT
        |FLOAT LES FLOAT
        |FLOAT BIGEQ FLOAT
        |FLOAT LESEQ FLOAT

        |VARIABLE ISEQ FLOAT
        |VARIABLE BIG FLOAT
        |VARIABLE LES FLOAT
        |VARIABLE BIGEQ FLOAT
        |VARIABLE LESEQ FLOAT

        |VARIABLE ISEQ INTEGER
        |VARIABLE BIG INTEGER
        |VARIABLE LES INTEGER
        |VARIABLE BIGEQ INTEGER
        |VARIABLE LESEQ INTEGER
        
        ;

%%
void yyerror(char *s) {
 fprintf(stderr, "%s\n", s);
 exit(0);
}

int main(void){
    yyparse();
    printf("OK\n");
    return 0;
}