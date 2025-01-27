x=20
def fun1():
    x=10
    print(x)
fun1()
print(x)
def fun2():
    global x
    x=30
fun2()
print(x)
10
20
30
