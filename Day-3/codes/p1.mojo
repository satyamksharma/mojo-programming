# 1.	Write a program to design a scientific calculator operations(any 10) using modules.

from python import Python

fn sum(a: Int, b: Int) raises:
    print(a+b)
fn diff(a: Int, b: Int) raises:
    print(a-b)
fn prod(a: Int, b: Int) raises:
    print(a*b)
fn div(a: Int, b: Int) raises:
    print(a/b)
fn modu(a: Int, b: Int) raises:
    print(a%b)
fn pow(a:Int, b: Int) raises:
    var py = Python.import_module('math')
    print(py.pow(a, b))
fn sin(a: Int) raises:
    var py = Python.import_module('math')
    print(py.sin(a))
fn cos(a: Int) raises:
    var py = Python.import_module('math')
    print(py.cos(a))
fn tan(a: Int) raises:
    var py = Python.import_module('math')
    print(py.tan(a))
fn log(a: Int) raises:
    var py = Python.import_module('math')
    print(py.log(a))
fn main() raises:
    var py = Python.import_module('builtins')
    var a = py.input('Enter 1st num: ')
    var b = py.input('Enter 2nd num: ')
    var num1 = atol(a)
    var num2 = atol(b)
    print("Sum : ")
    sum(num1, num2)
    print("Difference : ")
    diff(num1, num2)
    print("Product : ")
    prod(num1, num2)
    print("Quotient : ")
    div(num1, num2)
    print("Remainder : ")
    modu(num1, num2)
    print("Power : ")
    pow(num1, num2)
    print("Sine Value : ")
    sin(num1)
    print("Cosine Value : ")
    cos(num1)
    print("log : ")
    log(num1)
    print("Tangent : ")
    tan(num1)
        