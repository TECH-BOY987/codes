#include<iostream>
#include<conio.h>
#include<math.h>
using namespace std;
int main()
{
    float sum,fact=1,i,n,a,x;
    cout<<"enter the value of x and n:";
    cin>>x>>n;
    for(i=2,sum=1;i<n;i+=2)
    {
        a=pow(x,i);
        fact=(fact*(i-1)*i);
        sum=sum+a/fact;
    }
    cout<<"sum="<<sum;
    getch();
}