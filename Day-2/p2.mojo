# 2.	Define a global variable and show how it can be accessed and modified from different functions. Also, define a local variable within a function and demonstrate how it retains its value between function calls but is not accessible outside the function.


var n1 = 31
var n2 = 23

fn sum(n1:Int)->Int:
    return n1 + n2
fn diff(n2:Int)->Int:
    return n1 - n2

fn main():
    var n1: Int = 11
    var n2: Int = 16
    print(n1 + n2)
    print(sum(n1))
    print(diff(n2))