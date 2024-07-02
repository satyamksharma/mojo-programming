#4.	WAP to add two numbers using normal parameter declaration, inout, and borrowed argument convention. Also, print the original values in the main code after calling each function.

fn add(a: Int, b: Int)->Int:
    return (a + b)

fn add_inout(inout a: Int, inout b: Int)->Int:
    a = 23
    b = 31
    return (a + b)

fn add_borrowed(borrowed a: Int, borrowed b: Int)->Int:
    return a + b


fn main():
    var x: Int = 7
    var y: Int = 9
    print("Original numbers = ", x,"and", y)
    print(add(x, y))
    print(add_inout(x, y))
    print(add_borrowed(x, y))
    print("Final numbers = ", x,"and", y)

    