import bank
while True:
    print("1. deposit")
    print("2. withdraw")
    print("3. display balance")
    print("exit")
    op=int(input("enter the option:"))
    if op==1:
        amount=int(input("enter the amount:"))
        print(bank.deposit(amount))
    elif op==2:
        amount=int(input("enter the amount:"))
        print(bank.withdraw(amount))
    elif op==3:
        print("amount",bank.balance)
    else:
        break

Output:
1. deposit
2. withdraw
3. display balance
exit
enter the option:1
enter the amount:2000
deposit sucess New balance:2000
