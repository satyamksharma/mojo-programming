#7. WAP to calculate the grade of a student by reading 5 subject marks and calculate average.


from python import Python as py

def main():
    inp = py.import_module('builtins')

    print("Enter mark for subject 1: ")
    sub1 = inp.input("Enter a digit: ")
    print("Enter mark for subject2: ")
    sub2 = inp.input("Enter a digit: ")
    print("Enter mark for subject3: ")
    sub3 = inp.input("Enter a digit: ")
    print("Enter mark for subject4: ")
    sub4 = inp.input("Enter a digit: ")
    print("Enter mark for subject5: ")
    sub5 = inp.input("Enter a digit: ")


    total = sub1 + sub2 + sub3 + sub4 + sub5

    average = total // 5

    if average >= 90:
        grade =  "A"
    elif average >= 80:
        grade = "B"
    elif average >= 70:
        grade = "C"
    elif average >= 60:
        grade = "D"
    else:
        grade = "F"

    print("Average mark:", average)
    print("Grade:", grade)
