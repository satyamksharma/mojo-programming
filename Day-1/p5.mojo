#5. WAP to print odd and even numbers from 1-100.

def main():
    print("Even Numbers = ")
    for i in range(0,101):
        if i % 2 == 0:
            print(i, end=",")
        
    print("\nOdd Numbers = ")
    for i in range(0,101):
        if i % 2 != 0:
            print(i, end=",")