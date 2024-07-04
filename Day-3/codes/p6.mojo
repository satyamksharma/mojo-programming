# 6.	WAP to read a .CSV file using Pandas library in Mojo.

from python import Python as p

def main():
    pd = p.import_module("pandas")
    data = pd.read_csv("day.csv")
    print(data)
