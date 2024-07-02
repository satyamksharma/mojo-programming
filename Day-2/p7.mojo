# 7.	WAP to demonstrate multiple constructors with the help of method overloading.

struct Rectangle:
    var length: Float64
    var width: Float64

    fn __init__(inout self):
        self.length = 1.0
        self.width = 1.0

    fn __init__(inout self, side: Float64):
        self.length = side
        self.width = side

    fn __init__(inout self, length: Float64, width: Float64):
        self.length = length
        self.width = width

    fn area(self) -> Float64:
        return self.length * self.width

    fn display(self):
        print("Length:", self.length, "Width:", self.width, "Area:", self.area())

fn main():
    var rect1 = Rectangle()
    var rect2 = Rectangle(5.0)
    var rect3 = Rectangle(4.0, 6.0)

    rect1.display()
    rect2.display()
    rect3.display()
