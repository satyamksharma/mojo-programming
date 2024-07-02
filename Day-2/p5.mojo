#5.	WAP to demonstrate struct to a print student details with a constructor.

struct Person:
    var name: String
    var srn: String
    var branch: String

    fn __init__(inout self):
        self.name = "Satyam Kumar"
        self.srn = "PES2UG21CS486"
        self.branch = "CSE"

    fn __init__(inout self, name: String, srn: String, branch: String):
        self.name = name
        self.srn = srn
        self.branch = branch

    fn get_full_name(self) -> String:
        return self.name + " of branch " + self.branch + " SRN: " + self.srn

fn main():
    var client: Person = Person("Raghav", "PES2UG21CS481", "CSE")
    print(client.get_full_name())