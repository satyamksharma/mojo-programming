@value 
struct MyPet:
    var name:String 
    var age: Int

    fn __init__(inout self, owned name: String, age: Int):
        self.name = name
        self.age = age

    fn __copyinit__(inout self, existing: Self):
        self.name = existing.name
        self.age = existing .age

    fn __moveinit__(inout self, owned existing: Self):
        self.name = existing.name
        self.age = existing.age

    
