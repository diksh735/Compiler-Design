%{ 
    #include <stdio.h> 
    #include <string.h> 
    int opr_count = 0, opd_count = 0, valid = 1, top = -1, l = 0, j = 0, operands[10]; 
    char operators[10][10], stack[100]; 
%} 
%% 
"(" { 
	top++; 
	stack[top] = '('; 
} 
"{" { 
	top++; 
	stack[top] = '{'; 
} 
"[" { 
	top++; 
	stack[top] = '['; 
} 
")" { 
	if (stack[top] != '(') { 
		valid = 0;	 
	} 
	else if(opd_count>0 && (opd_count-opr_count)!=1){ 
		valid=0; 
	} 
	else{ 
		top--; 
		opd_count=1; 
		opr_count=0; 
	} 
} 
"}" { 
	if (stack[top] != '{') { 
		valid = 0;	 
	} 
	else if(opd_count>0 && (opd_count-opr_count)!=1){ 
		valid=0; 
	} 
	else{ 
		top--; 
		opd_count=1; 
		opr_count=0; 
	} 
} 
"]" { 
	if (stack[top] != '[') { 
		valid = 0; 
	} 
	else if(opd_count>0 && (opd_count-opr_count)!=1){ 
		valid=0; 
	} 
	else{ 
		top--; 
		opd_count=1; 
		opr_count=0; 
	} 
		
} 
"+"|"-"|"*"|"/" { 
	opr_count++;
    valid = 0;
	strcpy(operators[l], yytext); 
	l++; 
} 
[0-9]+ { 
	opd_count++;
    valid = 1;
	operands[j] = atoi(yytext); 
	j++; 
} 
%% 

int precedence(char op){
    if (op == '+'||op == '-')
        return 1;
    if (op == '*'||op == '/')
        return 2;
    return 0;
}

int applyOp(int a, int b, char op){
    switch(op){
        case '+': return a + b;
        case '-': return a - b;
        case '*': return a * b;
        case '/': return a / b;
    }
}

int evaluate(){
	int pre = 0;
    int ans=operands[0];
    int i=0;
    while(i<l){
    	if(i==l-1){
    		ans = applyOp(ans, operands[i+1], *operators[i]);
    		ans+=pre;
    	}
    	else{
    		if(precedence(*operators[i])==1){
    			if(precedence(*operators[i])==precedence(*operators[i+1]))
    				ans = applyOp(ans, operands[i+1], *operators[i]);
    			else{
    				pre+=ans;
    				if(*operators[i]=='-')
    					ans=-operands[i+1];
    				else
    					ans=operands[i+1];
    			}
    		}
    		else{
    			if(precedence(*operators[i])==precedence(*operators[i+1]))
    				ans = applyOp(ans, operands[i+1], *operators[i]);
    			else{
    				ans = applyOp(ans, operands[i+1], *operators[i]);
    				pre+=ans;
    				i++;
    				if(*operators[i]=='-')
    					ans=-operands[i+1];
    				else
    					ans=operands[i+1];
    				if(i==l-1)
    					ans+=pre;
    			}
    		}
    	}
    	i++;
    }
    return ans;
}

int yywrap(){ 
	return 1; 
} 
int main() 
{ 
	int k; 
	printf("Enter the arithmetic expression: "); 
	yylex(); 

	if (valid == 1 && top == -1) { 
		printf("\nValid Expression\n");
        printf("\nThe Answer is %d\n", evaluate());
	} 
	else
		printf("\nInvalid Expression\n"); 

	return 0; 
} 



