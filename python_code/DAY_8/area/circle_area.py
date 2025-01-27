def circle(r):
    area1=3.14*(r*r)
    return area1
def rectangle(l,b):
    area2=l*b
    return area2
while True:
    print("1)the area of circle")
    print("2)the area of rectangle")
    print("3)continue while the answer is no")
    a=int(input("enter the option:"))
    if(a==1):
        r=int(input("enter the radius:"))
        c=circle(r)
        print(c)
        break
    elif(a==2):
        l=int(input("enter the l:"))
        b=int(input("enter the b:"))
        r1=rectangle(l,b)
        print(r1)
        break
    else:
        print("There is no option")
        break

1)the area of circle
2)the area of rectangle
3)continue while the answer is no
1519.76
