# 6.	WAP to demonstrate a constructor for allocating the memory and a special function to deallocate the memory using struct.

from memory.unsafe import Pointer
struct MemoryExample:
    var data: Pointer[Int]
    var size: Int
    fn __init__(inout self, size: Int):
        self.size = size
        self.data = Pointer[Int].alloc(size)
        print("Memory allocated for", size, "integers")
    fn __del__(owned self):
        self.data.free()
        print("Memory deallocated")
    fn set_value(self, index: Int, value: Int):
        if index >= 0 and index < self.size:
            self.data.store(index, value)
        else:
            print("Index out of bounds")
    fn get_value(self, index: Int) -> Int:
        if index >= 0 and index < self.size:
            return self.data.load(index)
        else:
            print("Index out of bounds")
            return -1

fn main():
    var example = MemoryExample(5)
    example.set_value(0, 10)
    example.set_value(1, 20)
    example.set_value(2, 30)
    print("Value at index 1:", example.get_value(1))
