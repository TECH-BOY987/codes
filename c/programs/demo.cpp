 #include<iostream>
 using namespace std;
 int main()
 {
    int num,square,sum=0,i;
    cout<<"enter the limit:";
    cin>>num;
    for(i=1;i<=num;i++)
    {
        square=i*i;
        sum=sum+square;
    }
    cout<<"sum of squares of first"<<num<<"natural number="<<sum<<"\n";

 }