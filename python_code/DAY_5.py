"""1"""
t=[1,2,3,["annarose","tony","bob"],[4,5,6],(7,"god",23.3)]
t1=[10,11,12]
print(t)
e=t[::2]
print(e)
s=t[::-1]
print(s)
d=t[5][1]
print(d)
r=t[4]
print(r)
y=r[2]
print(y)
w=max(r)
print(w)
q=min(r)
print(q)
p=t[5]
print(list(p))
i=t[5]*2
print(i)
t.append(9)
print(t)
t.extend(t1)
print(t)
t.insert(2,2.5)
print(t)
"""ouotput"""
[1, 2, 3, ['annarose', 'tony', 'bob'], [4, 5, 6], (7, 'god', 23.3)]
[1, 3, [4, 5, 6]]
[(7, 'god', 23.3), [4, 5, 6], ['annarose', 'tony', 'bob'], 3, 2, 1]
god
[4, 5, 6]
6
6
4
[7, 'god', 23.3]
(7, 'god', 23.3, 7, 'god', 23.3)
[1, 2, 3, ['annarose', 'tony', 'bob'], [4, 5, 6], (7, 'god', 23.3), 9]
[1, 2, 3, ['annarose', 'tony', 'bob'], [4, 5, 6], (7, 'god', 23.3), 9, 10, 11, 12]
[1, 2, 2.5, 3, ['annarose', 'tony', 'bob'], [4, 5, 6], (7, 'god', 23.3), 9, 10, 11, 12]
"""2"""
a=[3,6,9,8,2]
print(a)
c=max(a)
print("the largest num=",c)
print("the index number=",a.index(c))
"""output"""
[3, 6, 9, 8, 2]
the largest num= 9
the index number= 2
"""3"""
l=[36,72,8]
m=[2,3,5]
a=[]
for i in range(len(l)):
    a.append(l[i]+m[i])
print(a)
"""output"""
[38, 75, 13]
"""4"""
a="this sentence is just an example to get largest word "
c=a.split()
largest=max(c,key=len)
print(largest)
"""output"""
sentence
"""5"""
first=[1,36,2,90,67,3,7,8,9]
second=[1,2,3,4,5,6,7,8,9]
list3=list(set(first)|set(second))
list3.sort()
print(list3)
"""output"""
[1, 2, 3, 4, 5, 6, 7, 8, 9, 36, 67, 90]
