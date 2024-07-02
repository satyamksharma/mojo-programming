# 1.	WAP to find the factorial of a given using the recursion function.


fn factorial(n: Int)->Int:
  if n == 0:
    return 1;
  else:
    return n * factorial(n - 1);


fn main() raises:
    alias result: Int = factorial(5)
    print("The factorial is", result);
