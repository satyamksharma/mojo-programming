struct myPair:
    var first: Int
    var second: Int

    fn __init__(inout self, first: Int, second: Int):
        self.first = first
        self.second = second

    fn gen_sum(self)->Int:
        return self.first + self.second

fn main():
    var mine = myPair(23, 31)
    print(mine.gen_sum())
    mine.first = 69
    print(mine.gen_sum())