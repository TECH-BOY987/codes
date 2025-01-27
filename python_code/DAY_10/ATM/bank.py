balance=0 
def check_balance(): 
  global balance 
  return balance 
def deposit(amount): 
  global balance balance+=amount 
  return f"deposit sucess New balance:{balance}" 
def withdraw(amount): 
  global balance 
  if amount>balance: 
    return "insufficent balance" 
  else: balance-=amount 
    return f"withdraw succesful. remaining balance:{balance}"
