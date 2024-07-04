# 3.	WAP to implement a ‘person’ struct with data members: name, age, email id and develop member functions: validate_data() with all necessary constructors using @value decorator.

@value
struct Pair:
    var name: String
    var age: Int
    var emailId: String

    def validate_date(self):
        if(self.name == "Admin" and self.age>=18):
            print("Admin login")
        else:
            print("wrong credentials")
        



fn main() raises:
    var x1 = Pair("Admin", 21, "ksatyam433@gmail.com")
    x1.validate_date()
    

