# 3.	Write an example program for declaring arguments with a default value and perform some mathematical operations.

fn add(first: Int, second: Int, /, third: Int=22) -> Int:
    return first + second + third
fn subtract(first: Int=251, * ,second: Int, third: Int) -> Int:
    return first - second - third
fn multiply(first: Int, second: Int, third: Int) -> Int:
    return first * second * third
fn divide(first: Int, second: Int) -> Int:
    return first // second 
fn modulus(first: Int, second: Int) -> Int:
    return first % second

fn main():
    print(add(1, 2, third=3))
    print(subtract(142, second=23, third=3))
    print(multiply(7, 2, 5))
    print(divide(186, 2))
    print(modulus(first=19, second=2 ))