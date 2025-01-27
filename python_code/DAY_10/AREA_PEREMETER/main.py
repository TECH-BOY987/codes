import Shapeop
import Shapeop.area
import Shapeop.perimeter
while True:
    print("1. circle")
    print("2. rectangle")
    print("3. square")
    print("4. error")
    n=int(input("enter the option:"))
    if n==1:
        r=int(input("enter the radius:"))
        area1=Shapeop.area.circle_area(r)
        area2=Shapeop.perimeter.circle_per(r)
        print(f"area result:{area1},perimeter:{area2}")
    elif n==2:
        l=int(input("enter the length:"))
        b=int(input("enter the breath:"))
        area3=Shapeop.area.rectangle_area(l,b)
        area4=Shapeop.perimeter.rectangle_per(l,b)
        print(f"area result:{area3},perimeter:{area4}")
    elif n==3:
        side=int(input("enter the side:"))
        area5=Shapeop.area.square_area(side)
        area6=Shapeop.perimeter.square_per(side)
        print(f"area result:{area5},perimeter:{area6}")
    else:
        break

Output:
1. circle
2. rectangle
3. square
4. error
enter the option:1
enter the radius:2
area result:12.566370614359172,perimeter:12.566370614359172

