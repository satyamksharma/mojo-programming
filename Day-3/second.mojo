@value
struct MyPet:
    var name: String
    var age: Int

fn main():
    var pet = MyPet("Brudo", 6)
    print("Name: ", pet.name)
    print("Age: ", pet.age)