#include<iostream>
using namespace std;
int main()
{
    int num,rem,sum=0,i;
    cout<<"enter a number:";
    cin>>num;
    for(i=num;i>0;i=i/10)
    {
        rem=i%10;
        sum=sum+rem;
    }
    cout<<"sum of digits="<<sum<<"\n";
}