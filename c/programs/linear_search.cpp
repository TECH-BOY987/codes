#include<iostream>
#include<conio.h>
using namespace std;
int linear(int A[],int n,int e)
{
for(int i=0;i<n;i++)
{
    if(A[i]==element)
    return i;
}
return-1;
}
int main()
{
    int A[10],n,e,p;
    cout<<"enter the size of the array:";
    cin>>n;
    cout<<"enter the element into the array:";
    for(int i=0;i<n;i++)
    cin>>A[i];
    cout<<"enter the element to be searched for";
    cin>>e;
    p=linear(A,n,e);
    if(p==-1)
    cout<<"element not present in position";
    else
    cout<<"element is foundd in position"<<p+1;
    getch();
}