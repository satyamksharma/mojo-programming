#8.	Write example program to demonstrate __copyinit__() constructor.   

struct Person:
    var name: String
    var age: Int

    fn __init__(inout self, name: String, age: Int):
        self.name = name
        self.age = age
        print("Regular constructor called for", self.name)

    fn __copyinit__(inout self, existing: Self):
        self.name = existing.name + " (copy)"
        self.age = existing.age
        print("Copy constructor called for", self.name)

    fn display(self):
        print("Name:", self.name, "Age:", self.age)

fn main():

    var original = Person("Satyam", 21)
    original.display()
    var copy = original
    copy.display()
    copy.age = 31
    copy.display()
    original.display()
