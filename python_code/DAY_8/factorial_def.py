def factorial(n):
    if n==0:
        print(n)
        return 1
    else:
        print(n,"*",end=" ")
        return n*factorial(n-1)
n=int(input("enter the number:"))
r=factorial(n)
print(f"the factorial of {n}:",r)
3 * 2 * 1 * 0
the factorial of 3: 6
