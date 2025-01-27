"""1"""
P=int(input("enter the value of p= "))
R=int(input("enter the value of R="))
T=int(input("enter the value of T="))
SI=(P*R*T)/100
#print("P=",P,"R=",R,"T=",T)
#print(f"P={P} and R={R} and T={T}")
print("P={} and R={} and T={}".format(P,R,T))
print("the SI equal to ",SI)
"""output"""
P=20 and R=20 and T=20
the SI equal to  80.0
"""2"""
a=int(input("enter the number= "))
if (a/3)or(a/6):
    print("the number is divisible")
else:
    print("not divisible")
"""output"""
the number is divisible
"""3"""
num1=int(input("enter the number= "))
num2=int(input("enter the number= "))
num3=int(input("enter the number= "))
if (num1>num2) and (num1>num3):
    print("true num1 is largest")
elif (num2>num1) and (num2>num3):
    print("true num2 is largest")
elif (num3>num1) and (num3>num2):
    print("true num3 is largerst")    
"""output"""    
true num3 is largerst
"""4"""
a=int(input("enter the number= "))
b=int(input("enter the number= "))
op=input("enter the operator= ")
if (op=="+"):
    print("value while adding=",a+b)
elif (op=="-"):
    print("the value while subtracting= ",a-b)
elif (op=="*"):
    print("the value while multiplying= ",a*b)
elif (op=="/"):
    print("the value while dividing= ",a/b)
"""output"""
value while adding= 35
"""5"""
a=int(input("enter the length= "))
b=int(input("enter the length= "))
c=int(input("enter the length= "))
if (a==b==c):
    print("the triangle is eqalateral")
elif (a==b) or (a==c) or (b==c): 
    print("the triangle is isoscales")
else:
    print("scalene")
"""output"""
the triangle is isoscales
"""6"""
a=int(input("enter the number= "))
b=int(input("enter the number= "))
print(bin(a))
print(bin(b))
and_gate=bin(a&b)
print("and= ",and_gate)
or_gate=bin(a|b)
print("or= ",or_gate)
not_gate=bin(~a)
print("not= ",not_gate)
xor_gate=bin(a^b)
print("xor= ",xor_gate)
xnor_gate=bin(~(a^b))
print("xnor= ",xnor_gate)
left_shift=bin(a<<2)
print("left_shift= ",left_shift)
right_shift=bin(a>>1)
print("right_shift= ",right_shift)
"""output"""
0b10111
0b1100
and=  0b100
or=  0b11111
not=  -0b11000
xor=  0b11011
xnor=  -0b11100
left_shift=  0b1011100
right_shift=  0b1011
"""7"""
a=4
type(a)
a1=31.2
type(a1)
"""output"""
float
"""8"""
i=0
while(i<10):
    i=i+1
    print(i)
"""output"""    
1
2
3
4
5
6
7
8
9
10
"""9"""
a=int(input("enter the number"))
print("the digit:",a)
print("the number of digits",len(str(abs(a))))
"""output"""
the digit: 234
the number of digits 3
"""10"""
i=1
fact=1
while(i<10):
    fact=fact*i
    i=i+1
    print(fact)
"""output"""
1
2
6
24
120
720
5040
40320
362880
"""11"""
num=int(input("enter the number= "))
print("the N'th number:",num)
i=1
sum=0
while(i<=num):
    sum+=i
    i=i+1
print("sum of n natural numbers",sum)
"""output"""
the n'th number: 23
sum of n natural numbers 276
"""12"""
a=876543
large=0
while a>0:
    if (large<a%10):
        large=a%10
        a=a//10
print("large:",large)
"""output"""
large: 8
"""13"""
d=20
s=40
if d>s:
    pass
else:
    print("error")
"""output"""
error
