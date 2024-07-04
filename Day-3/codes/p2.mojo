# 2.	Write a program to read student marks information and generate a result with cgpa using biotin functions.

from python import Python
fn main() raises:
    var py = Python.import_module('builtins')
    var py2 = Python.import_module('math')
    var a = py.input("Enter grade 1: ")
    var b = py.input("Enter grade 2: ")
    var c = py.input("Enter grade 3: ")
    var d = py.input("Enter grade 4: ")
    var e = py.input("Enter grade 5: ")

    var sub1 = atol(a)
    var sub2 = atol(b)
    var sub3 = atol(c)
    var sub4 = atol(d)
    var sub5 = atol(e)

    var gpa = (sub1 + sub2 + sub3 + sub4 + sub5) / 5

    print("Your GPA: ", gpa)