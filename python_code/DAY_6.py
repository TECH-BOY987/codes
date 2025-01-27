"""1"""
a=list(eval(input("enter the list:")))
print(a)
largest=0
for i in range(len(a)):
    if a[i]>largest:
        largest=a[i]
        index=i
print(f"largest={largest} \nindex={index}")
"""output"""
[2, 3, 1, 6, 7]
largest=7 
index=4
"""2"""
first=[1,2,3]
second=[78,5,3]
a=[]
for i in range(len(first)):
    a.append(first[i]+second[i])
print(a)
"""output"""
[79, 7, 6]
"""3"""
square=[x**2 for x in range(1,11)]
print(square)
[1, 4, 9, 16, 25, 36, 49, 64, 81, 100]
a=tuple([(1,2),(3,4),(5,6)])
c=a[0]+a[1]+a[2]
square=[x**2 for x in range(1,11)]
print(c)
print(len(c))
print("the largest element of the touple:",max(c))
print(tuple(square))
"""output"""
(1, 2, 3, 4, 5, 6)
6
the largest element of the touple: 6
(1, 4, 9, 16, 25, 36, 49, 64, 81, 100)
"""4"""
nptl=("hello","nita","how's","life?")
(a,b,c,d)=nptl
print(a)
print(b)
print(c)
print(d)
nptl=(a,b,c,d)
print(nptl[0][0]+nptl[1][1]," ",nptl[1])
"""output"""
hello
nita
how's
life?
hi   nita
"""5"""
a=("tom","marvolo","riddle")
(e,f,g)=a
print(e)
print(f)
print(g)
a=(e,f,g)
print(a[2][1],"",a[1][1]+a[0][2],"",a[1][5]+a[1][6]+a[2][0]+a[2][2],"",a[1][3]+a[0][1]+a[2][4]+a[2][3]+a[2][5]+a[1][0]+a[1][4]+a[1][2]+a[0][0])
"""output"""
tom
marvolo
riddle
i  am  lord  voldemort
"""6"""
a={'a':'apple','b':'orange','c':'grapes'}
print(a)
print(a['a'])
for i in a:
    print(i,":",a[i])
    a.keys()
a['d']="god"
print(a)
a.items()
for k,v in a.items():
    print(k,":",v)
a[0]=23
a[1]=231
a[2]=21
a[3]=12
print(a)
"""output"""
{'a': 'apple', 'b': 'orange', 'c': 'grapes'}
apple
a : apple
b : orange
c : grapes
{'a': 'apple', 'b': 'orange', 'c': 'grapes', 'd': 'god'}
a : apple
b : orange
c : grapes
d : god
{'a': 'apple', 'b': 'orange', 'c': 'grapes', 'd': 'god', 0: 23, 1: 231, 2: 21, 3: 12}
s=[(1,2),(2,4)]
dict(s)
{1: 2, 2: 4}
