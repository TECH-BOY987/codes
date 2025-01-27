"""1"""
s=input("enter the name ")
print(s[::-1])
"""output"""
jareen
"""2"""
s=input("enter the name ")
if (s==s[::-1]):
    print("PALINDROME")
else:
    print("NOT PALINDROME")
"""output"""
PALINDROME
"""3"""
s=input("enter the name ")
print(s)
digits=0
alpha=0
uppercase=0
lowercase=0
for char in s:
    if(char.isdigit()):
        digits=digits+1
    elif(char.isalpha()):
        alpha=alpha+1
    elif(char.isupper()):
        uppercase=uppercase+1
    elif(char.islower()):
        lowercase=lowercase+1  
print(f"digits={digits}\nalpha={alpha}\nuppercase={uppercase}\nlowercase={lowercase}")
"""output"""
neeraj NEERAJ 26712
digits=5
alpha=12
uppercase=0
lowercase=0
"""4"""
s=input("enter the string ")
a=" "
for char in s:
    if(char in "aeiou"):
        continue
    a+=char
print(a)
"""output"""
 nrj
"""5"""
s=input("enter the string ")
title_s=s.title()
title_s[::-1]
print(title_a)
"""output"""
Neeraj
"""6"""
a="gmail@com"
c=""
for char in a:
    if(char.islower()):
        c+=char.upper()
    if(char=="@"):
        c+="bb"
print(c)
"""output"""
GMAILbbCOM
