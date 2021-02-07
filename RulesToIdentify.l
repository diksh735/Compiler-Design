%{
int lines=0, words=0, c_letters=0, s_letters=0, nums=0, digits=0, spchars=0, delim=0, operator=0, r_operators=0, chars=0;
%}

%%
"\n" {
    lines++;
}
[ \t]+ {
    words++;
}
[A-Z] {
    c_letters++;
    chars++;
}
[a-z] {
    s_letters++;
    chars++;
}
[0-9]* {
    int num = atoi(yytext);
    if (num <= 21 && num >= 10) {
        nums++;
    }
    digits += yyleng;
    chars += yyleng;
}
"+"|"-"|"*"|"/" {
    operator++;
    chars++;
    spchars++;
}
"="|"<"|">" {
    r_operators++;
    chars++;
    spchars++;
}
[:,;\|{}()] {
    delim++;
    chars++;
}

. {
    chars += yyleng;
    spchars += yyleng;
}
%%

int main(int argc, char* argv[])
{
    //yyin = fopen(argv[1], "r");
yylex();
printf("The input contains: \n ");
printf("Lines: %d,\t\nWords: %d,\t\nCapital Letters: %d,\t\nSmall Letters: %d,\t\nNumbers between 10 to 21: %d,\t\nDigits: %d,\t\nSpecial Character: %d,\t\nDelimiter: %d,\t\nOperator: %d,\t\nRelational Operator: %d,\t\nTotal Characters: %d\n",lines, words, c_letters, s_letters, nums, digits, spchars, delim, operator, r_operators, chars);
} 

int yywrap() {}



