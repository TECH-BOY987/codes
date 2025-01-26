"""1"""
a=4
c=5
d=a+c
print(d)
"""output"""
9
"""2"""
age=int(input("enter age="))
if age>=16:
    print("vote")
else:
    print("no vote")
"""output"""
vote
"""3"""
num=int(input("enter number="))
if num%2==0:
    print("even number")
else:
    print("odd number")
"""output"""
even number
"""4"""
a=int(input("enter number="))
d=int(input("enter number"))
c=int(input("enter number"))
if (a+d+c)==180:
    print("true")
else:
    print("false")
"""output"""
false
"""4"""
year=int(input("year= "))
if (year%4==0 and year%100!=0)or year%400==0:
#if year%4==0:
    print("leap year")
else:
    print("not leap year")
"""output"""
not leap year
"""5"""
a=int(input("number "))
c=int(input("number2 "))
s=a//c
print("s=",s)
"""output"""
s= 1
"""6"""
a=int(input("enter the number "))
c=int(input("enter the number "))
#s=a
#a=c
#c=s
a,c=c,a
print("a=",a,"b=",c)
"""output"""
a= 3 b= 2
"""7"""
a=int(input("number "))
c=int(input("number2 "))
s=a%c
print("s=",s)
"""output"""
s= 2
"""8"""
c=float(input("enter celcius "))
f=(c*(9/5))+32
print("feranheat ",f)
"""output"""
feranheat  89.96000000000001
