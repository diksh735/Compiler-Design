%{  
#include <stdio.h>  
%}  

%%  
[a-zA-Z_][a-zA-Z0-9_]* {printf("This is an Identifier\n");}  
[0-9]* {printf("This is a Constant\n");}
%%  
   
int main()  
{       
    yylex();      
} 

int yywrap() {}




