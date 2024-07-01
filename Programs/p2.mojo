#2. Write a program to print the factorial of a number using control statements.

def main():
    n = 5 

    if n < 0:
        print("Number less than 0")
    elif n == 0 or n == 1:
        print("The factorial is : ", 1)
    else:
        result = 1
        for i in range(2, n + 1):
            result *= i
        print("The factorial is : ", result)


    