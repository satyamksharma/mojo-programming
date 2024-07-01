#8. WAP to read two numbers and using Boolean variables print the relationship between two numbers(=, <, >)

from python import Python as py

def main():
    inp = py.import_module('builtins')
    n1 = inp.input("Enter a digit: ")
    n2 = inp.input("Enter a digit: ")
    
    if n1 > n2:
        print("Number 1 is Greater")
    elif n2 > n1:
        print("Number 2 is Greater")
    else:
        print("Numbers are equal")