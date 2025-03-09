#include<iostream>
#include<conio.h>
using namespace std;
int binary (int A[],int n,int e)
{
    int beg=0,last=n-1,mid;
    while(beg<=last)
    {
        mid=beg+last/2;
        if(A[mid]==e)
        return mid;
        else
        if(A[mid]>e)
        last=mid-1;
        else
        beg=mid+1;
    }
    return-1;
}
int main()
{
    int A[10],n,e,p;
    cout<<"enter the size of the array:";
    cin>>n;
    cout<<"enter the element in ascending order:";
    for(int i=0;i<=n;i++)
    cin>>A[i];
    cout<<"enter the elementnto be searched";
    cin>>e;
    p=binary(A,e,n);
    if(p==1)
    cout<<"element not present in position";
    else
    cout<<"element present in position"<<p+1;
    getch();
}