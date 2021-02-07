%{
#include<stdio.h>
#include<string.h>
int nwords = 0, nchar=0;
%}

%%
[^ \n\t]+ {nwords++, nchar=nchar+yyleng;}
. {nchar++;}
\n {return 0;}
%%

int yywrap(){}

int main()
{
yylex();
printf("\nNo. of Words=%d\nNo. of Characters=%d\n",nwords, nchar);
return 0;
}



