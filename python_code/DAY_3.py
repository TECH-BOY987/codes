"""1"""
i=0
while(i<20):
    i=i+1
    if(i==15):
        continue
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
11
12
13
14
16
17
18
19
20
"""2"""
i=0
while(i<20):
    i=i+1
    if(i==15):
        break
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
11
12
13
14
"""3"""
a=int(input("enter the number= "))
for i in range(a):
    print(i)
"""output"""
0
1
"""4"""
for i in range(1,50,2):
    print(i)
for j in range(50):
    if(j%2==1):
        print(j)
"""output"""
1
3
5
7
9
11
13
15
17
19
21
23
25
27
29
31
33
35
37
39
41
43
45
47
49
1
3
5
7
9
11
13
15
17
19
21
23
25
27
29
31
33
35
37
39
41
43
45
47
49
"""5"""
n=int(input("enter the number= "))
for i in range(1,11):
    print(f"{i}x{n}={i*n}")
"""output"""
1x3=3
2x3=6
3x3=9
4x3=12
5x3=15
6x3=18
7x3=21
8x3=24
9x3=27
10x3=30
"""6"""
a=int(input("enter number= "))
c=int(input("enter number= "))
sum=0
for i in range(1,c+1,1):
        sum=sum+a
print(sum)
"""output""'
12
"""7"""
for i in range(1,100):
    if(i%2==0):
        continue
    print(i)
"""output"""   
1
3
5
7
9
11
13
15
17
19
21
23
25
27
29
31
33
35
37
39
41
43
45
47
49
51
53
55
57
59
61
63
65
67
69
71
73
75
77
79
81
83
85
87
89
91
93
95
97
99
"""8"""
for i in range(1,100):
    if(i%7==0)and(i%13==0):
        print(i)
        break
"""output"""
91
for i in range(1,50):
    if(i%5==0) or (i%7==0):
         continue
    print(i)
1
2
3
4
6
8
9
11
12
13
16
17
18
19
22
23
24
26
27
29
31
32
33
34
36
37
38
39
41
43
44
46
47
48
"""9""" 
for i in range(5):
    for j in range(i+1):
        print(j,end="")
    print()
"""output"""
0
01
012
0123
01234
"""10"""
for i in range(5):
    for j in range(i+1):
        print("*",end=" ")
    print()
"""output"""
* 
* * 
* * * 
* * * * 
* * * * * 
"""11"""
n=5
for i in range(n):
    for j in range(n+1):
        print("*",end=" ")
    print()
"""output"""
* * * * * * 
* * * * * * 
* * * * * * 
* * * * * * 
* * * * * * 
"""12"""
n=5
a=0
for i in range(n):
    for j in range(i+1):
        a=a+1
        print(a,end=" ")
    print()
"""output"""
1 
2 3 
4 5 6 
"""13"""
for i in range(1,6):
    print(" "*(5-i)*2,end=" ")
    for j in range(1,i+1):
        print("*   ",end="")
    print()
"""output""'        
    
         *   
       *   *   
     *   *   *   
   *   *   *   *   
 *   *   *   *   *  
"""14"""
for i in range(1,6):
    print(" "*(5-i)*2,end="")
    for j in range(1,i+1):
        print(chr(64+j),end="   ")
    print()
"""output"""
        A   
      A   B   
    A   B   C   
  A   B   C   D   
A   B   C   D   E  
"""15"""
n=int(input("enter number"))
for i in range(1,n+1,1):
        print("*"*i)
a=int(input("enter number"))
for j in range(a,0,-1):
        print("*"*j)
"""output"""
*
**
***
****
*****
******
*****
****
***
**
*
******
*****
****
***
**
*
