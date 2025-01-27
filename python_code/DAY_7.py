"""1"""
d={}
for i in range(1,16):
    d[i]=i*i
print(d)
"""output"""
{1: 1, 2: 4, 3: 9, 4: 16, 5: 25, 6: 36, 7: 49, 8: 64, 9: 81, 10: 100, 11: 121, 12: 144, 13: 169, 14: 196, 15: 225}
"""2"""
d={4:16,7:49,2:4}
sort_dict=dict(sorted(d.items()))
print(sort_dict)
"""output"""
{2: 4, 4: 16, 7: 49}
"""3"""
str="google.com"
d={}
for i in str:
    d[i]=str.count(i)
print(d)
# if i in d:without_count
#     d[i]+=1
# else:
#     d[i]=1
# print(d)
"""output"""
{'g': 2, 'o': 3, 'l': 1, 'e': 1, '.': 1, 'c': 1, 'm': 1}
"""4"""
dict1={"a":"apple","b":"ball","c":"cat"}
dict2={"d":"dog","e":"egg"}
dict1.update(dict2)
print(dict1)
"""output"""
{'a': 'apple', 'b': 'ball', 'c': 'cat', 'd': 'dog', 'e': 'egg'}
"""5"""
d={'a':100,'b':200,'c':300}
d1={'a':300,'b':200,'d':400}
result=d
for i in d1:
    if i in d.keys():
        result[i]=d[i]+d1[i]
    else:
        result[i]=d1[i]
print(result)
"""output"""
{'a': 400, 'b': 400, 'c': 300, 'd': 400}
"""6"""
s={1,2,3,4,5,2,3}   
a=set([1,2,3,5,6,2])
a.add(20)
print(a)
q=s.union(a)
print(q)
q.remove(20)
print(q)
n=s.intersection(a)
print(n)
e=s.issubset(a)
print(e)
for element in n:
    print(q)
a=[2,1,3,1,5,3,21,5]
q=set(a)
o=list(q)
print(o)
print(3 in q)
w="google.com"
d=set(w)(
print("".join(d)))
"""output"""
{1, 2, 3, 5, 6, 20}
{1, 2, 3, 4, 5, 6, 20}
{1, 2, 3, 4, 5, 6}
{1, 2, 3, 5}
False
{1, 2, 3, 4, 5, 6}
{1, 2, 3, 4, 5, 6}
{1, 2, 3, 4, 5, 6}
{1, 2, 3, 4, 5, 6}
[1, 2, 3, 5, 21]
True
glc.ome
"""7"""
def fun1(a,b):
    result=a*b
    return result
a=10
b=21
c=fun1(a,b)
print(c)
"""output"""
210
"""8"""
def fun1(i):
    pre=0
    cur=1
    if i<=2:
        print(pre,cur)
    else:
        print(pre)
        print(cur)
        for j in range(2,i):
            result=pre+cur
            print(result)
            pre,cur=cur,result
i=int(input("enter:"))
fun1(i)
"""output"""
0
1
1
2
3
5
8
13
21
"""9"""
def fun1():
    a,b=0,1
    while True:
        yield a
        a,b=b,a+b
fib=fun1()
for i in range(10):
    print(next(fib))
"""output"""
0
1
1
2
3
5
8
13
21
34
"""10"""
def sum1(a,d):
    return a+d
num1=10
num2=2
c=sum1(num1,num2)
print("the result is",c)
"""output"""
the result is 12
