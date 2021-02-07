#include<bits/stdc++.h>
using namespace std;

int main()
{
string r;
int temp[20][3];
memset(temp,0,sizeof(temp));
cout<<"Enter Regular Expressions"<<endl;
cin>>r;
int n=r.length();
int i=0;
int j=1;
while(i<n)
{
if(r[i]=='a' && r[i+1]!='/' && r[i+1]!='*')
{
temp[j][0]=j+1;
j++;
}
if(r[i]=='b' && r[i+1]!='/' && r[i+1]!='*')
{
temp[j][1]=j+1;
j++;
}
if(r[i]=='e' && r[i+1]!='/' && r[i+1]!='*')
{
temp[j][2]=j+1;
j++;
}
if(r[i]=='a' && r[i+1]=='/' && r[i+2]=='b')
{
temp[j][2]=((j+1)*10)+(j+3);
j++;
temp[j][0]=j+1;
j++;
temp[j][2]=j+3;
j++;
temp[j][1]=j+1;
j++;
temp[j][2]=j+1;
j++;
i=i+2;
}
if(r[i]=='b' && r[i+1]=='/' && r[i+2]=='a')
{
temp[j][2]=((j+1)*10)+(j+3);
j++;
temp[j][1]=j+1;
j++;
temp[j][2]=j+3;
j++;
temp[j][0]=j+1;
j++;
temp[j][2]=j+1;
j++;
i=i+2;
}
if(r[i]=='a' && r[i+1]=='*')
{
temp[j][2]=((j+1)*10)+(j+3);
j++;
temp[j][0]=j+1;
j++;
temp[j][2]=((j+1)*10)+(j-1);
j++;
}
if(r[i]=='b' && r[i+1]=='*')
{
temp[j][2]=((j+1)*10)+(j+3);
j++;
temp[j][1]=j+1;
j++;
temp[j][2]=((j+1)*10)+(j-1);
j++;
}
if(r[i]==')' && r[i+1]=='*')
{
temp[0][2]=((j+1)*10)+1;
temp[j][2]=((j+1)*10)+1;
j++;
}
i++;
}
cout<<"Transition function"<<endl;
for(i=0;i<=j;i++)
{
if (temp[i][0] != 0)
cout<<endl<<"q["<<i<<",a]-->"<<temp[i][0];
if (temp[i][1] != 0)
cout<<endl<<"q["<<i<<",b]-->"<<temp[i][1];
if (temp[i][2] != 0)
{
if (temp[i][2] < 10)
cout<<endl<<"q["<<i<<",e]-->"<<temp[i][2];
else
cout<<endl<<"q["<<i<<",e]-->"<<temp[i][2]/10<<"&"<<temp[i][2] % 10;
}
cout<<endl;
}
}
