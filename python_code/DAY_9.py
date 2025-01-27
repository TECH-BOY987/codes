"""1"""
class animal:
    def __init__(self,name):
        self.name=name
class dog(animal):
    def speak(self):
        return f"{self.name} says wooff!"
class cat(animal):
    def speak(self):
        return f"{self.name} says meow!"
Dog=dog("buddy")
Cat=cat("tom")
print(Dog.speak())
print(Cat.speak())
"""output"""
buddy says wooff!
tom says meow!
"""2"""
class bank:
    bank_name="boi"
    rate=12.34
    @staticmethod
    def simple_intrest(prin,n):
        si=(prin*n*bank.rate)/100
        print("simple intrest",si)
prin=float(input(("enter the number:")))
bank.simple_intrest(prin,3)
"""output"""
simple intrest 1.1846400000000001
"""3"""
class father:
    def __init__(self):
        print("father constructor called")
        self.vehicle="scooter"
class son(father):
    def __init__(self):
        print("son constructor called")
        self.vehicle="car"
s=son()
print(s.__dict__)
"""output"""
son constructor called
{'vehicle': 'car'}
"""4"""
class employee:
    company_name="infosys"
    def __init__(self):
        self.name="vikas"
        self.age=22
    def display(self):
        print(f"name:{self.name} age:{self.age}")
    @classmethod
    def get_company_name(cls):
        print(f"company name:{cls.company_name}")
        cls.company_name="aaa"
        print(f"company name:{cls.company_name}")
e=employee()
e.display()
print(employee.company_name)
employee.company_name="TCS"
print(employee.company_name)
employee.get_company_name()
"""output"""
name:vikas age:22
infosys
TCS
company name:TCS
company name:aaa
"""5"""
class computer:
    def __init__(self):
        self.ram="8gb"
        self.storage="512gb"
        print("computer class called")
class mobile(computer):
    def __init__(self):
        super().__init__()
        self.model="i phone x"
        print("mobile class called")
apple=mobile()
print(apple.__dict__)
"""output"""
computer class called
mobile class called
{'ram': '8gb', 'storage': '512gb', 'model': 'i phone x'}
"""6"""
class vehicle:
    def __init__(self,name,color,prize):
        self.name=name
        self.color=color
        self.prize=prize
    def get_details(self):
        print(f"name:{self.name},color:{self.color},prize:{self.prize}")
    def max_speed(self):
        print("max speed is 120km")
    def gear_change(self):
        print("gear change: 6") 
class car(vehicle):
    def max_speed(self):
        print("max speed 60km")
    def gear_change(self):
        print("gear change: 7")
v1=vehicle("trunk","red",2000000)
c1=car("car","white",30000000)
v1.get_details()
c1.get_details()
v1.max_speed()
c1.max_speed()
v1.gear_change()
"""output"""
name:trunk,color:red,prize:2000000
name:car,color:white,prize:30000000
max speed is 120km
max speed 60km
gear change: 6
"""7"""
from abc import ABC,abstractmethod
class shape(ABC):
    @abstractmethod
    def area(self):
        pass
class rectangle(shape):
    def __init__(self,width,height):
        self.width=width
        self.height=height
    def area(self):
        return self.width*self.height
class square(shape):
    def __init__(self,side):
        self.side=side
    def area(self):
        return self.side*self.side
rect=rectangle(5,4)
squ=square(2)
print("area of rectangle:",rect.area())
print("area of square:",squ.area())
"""output"""
area of rectangle: 20
area of square: 4
"""8"""
class car:
    def __init__(self,make,mode):
        self.make=make
        self.mode=mode
        self.__speed=0
    def accelerate(self,amount):
        self.__speed+=amount
    def get_speed(self):
        return self.__speed
my_car=car("toyota","camry")
my_car.accelerate(50)
print("current speed:",my_car.get_speed())
"""output"""
current speed: 50
