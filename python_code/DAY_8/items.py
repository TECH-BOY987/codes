def p_info(**kwargs):
    for key,value in kwargs.items():
        print(f"{key}:{value}")
p_info(name="alice",age=22,city="york")
name:alice
age:22
city:york
