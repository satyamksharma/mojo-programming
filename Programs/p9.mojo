#9. Evaluate an expression using python evaluate function in mojo.

from python import Python as py


def main():
    inp = py.import_module('builtins')

    expression = inp.input("Enter an expression to evaluate: ")
    result = inp.eval(expression)
    print("The result of the expression is:", result)
    