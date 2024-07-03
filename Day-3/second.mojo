from python import Python
def main():
    var plt = Python.import_module("matplotlib.pyplot")
    x = ["A", "B", "C", "D", "E"]
    y = [1, 2, 3, 4, 5]
    plt.bar(x,y)
    plt.show()