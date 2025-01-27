def greet(name,greeting):
    return f"{greeting},{name}!"
print(greet("alice","hello"))
print(greet(greeting="hello",name="alice"))
def greet(name,greeting="hello"):
    return f"{greeting},{name}!"
print(greet("alice"))
hello,alice!
hello,alice!
hello,alice!
