import area
while True:
    print("1. circle")
    print("2. rectangle")
    print("3. square")
    print("4. error")
    n=int(input("enter the option:"))
    if n==1:
        r=int(input("enter the radius:"))
        area1=area.circle(r)
        print("result:",area1)
    elif n==2:
        l=int(input("enter the length:"))
        b=int(input("enter the breath:"))
        area2=area.rectangle(l,b)
        print("result:",area2)
    elif n==3:
        side=int(input("enter the side:"))
        area3=area.square(side)
        print("result:",area3)
    else:
        break

Output:
1. circle
2. rectangle
3. square
4. error
enter the option:1
enter the radius:3
result: 28.274333882308138
