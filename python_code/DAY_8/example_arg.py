def ex(name,*args,greeting="hello",age=30,**kwargs):
    print(f"name:{name}")
    print(f"age:{age}")
    print(f"greeting:{greeting}")
    print("additional position")
    for arg in args:
        print(arg)
        print("additional keyword arguments")
    for key,value in kwargs.items():
        print(f"{key}:{value}")
ex("alice","extra1","extra2",city="newyork",professsion="engineer")
name:alice
age:30
greeting:hello
additional position
extra1
additional keyword arguments
extra2
additional keyword arguments
city:newyork
professsion:engineer
