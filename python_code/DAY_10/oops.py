class employee:
    def __init__(self,name,age,salary):
        self.name=name
        self.age=age
        self.salary=salary
    def display(self):
        print(f"name={self.name},age={self.age},salary={self.salary}")
e1=employee("sunil",20,20000)
e1.display()
print(e1.name)
Output:
name=sunil,age=20,salary=20000
sunil
