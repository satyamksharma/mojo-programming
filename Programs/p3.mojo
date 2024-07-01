#3. WAP to print the first 20th Fibonacci Number using control statements in Mojo.

def main():

    var a: Int = 0
    var b: Int = 1
    var c: Int = 0
    var count: Int = 2

    while count < 20:
        c = a + b
        a = b
        b = c
        count += 1

    print("The 20th Fibonacci number is:", b)
