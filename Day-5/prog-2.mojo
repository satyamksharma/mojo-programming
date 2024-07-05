# 2.	WAP using a multi-layer perceptron model in mojo taking three inputs and having atleast 3 nodes in the hidden layer for implementation of universal logical gates. 

from math import exp, tanh
from random import seed, random_float64
from time import now

struct Array:
    var data: Pointer[Float64]
    var size: Int
   
    fn __init__(inout self, size: Int):
        self.size = size
        self.data = Pointer[Float64].alloc(self.size)

    fn __init__(inout self, size: Int, default_value: Float64):
        self.size = size
        self.data = Pointer[Float64].alloc(self.size)
        for i in range(self.size):
            self.data.store(i, default_value)

    fn __copyinit__(inout self, copy: Array):
        self.size = copy.size
        self.data = Pointer[Float64].alloc(self.size)
        for i in range(self.size):
            self.data.store(i, copy[i])

    fn __getitem__(self, i: Int) -> Float64:
      return self.data.load(i)

    fn __setitem__(self, i: Int, value: Float64):
      self.data.store(i, value)

    fn __del__(owned self):
      self.data.free()

    fn len(self) -> Int:
      return self.size

struct Array2D:
    var data: Pointer[Float64]
    var sizeX: Int
    var sizeY: Int
   
    fn __init__(inout self, sizeX: Int, sizeY: Int):
        self.sizeX = sizeX
        self.sizeY = sizeY
        self.data = Pointer[Float64].alloc(self.sizeX * sizeY)

    fn __init__(inout self, sizeX: Int, sizeY: Int, default_value: Float64):
        self.sizeX = sizeX
        self.sizeY = sizeY
        self.data = Pointer[Float64].alloc(self.sizeX * self.sizeY)
        for i in range(self.sizeX * self.sizeY):
            self.data.store(i, default_value)

    fn __copyinit__(inout self, copy: Array2D):
        self.sizeX = copy.sizeX
        self.sizeY = copy.sizeY
        self.data = Pointer[Float64].alloc(self.sizeX * self.sizeY)
        for i in range(self.sizeX * self.sizeY):
            self.data.store(i, copy[i])

    fn __getitem__(self, i: Int, j: Int) -> Float64:
        return self[self.sizeY * i + j]

    fn __getitem__(self, i: Int) -> Float64:
      return self.data.load(i)

    fn __setitem__(self, i: Int, value: Float64):
      self.data.store(i, value)

    fn __setitem__(self, i: Int, j: Int, value: Float64):
        self[self.sizeY * i + j] = value

    fn __del__(owned self):
      self.data.free()

    fn len(self) -> Int:
      return self.sizeY * self.sizeX

    fn rows(self) -> Int:
        return self.sizeX

    fn columns(self) -> Int:
        return self.sizeY

struct NeuralNetwork:
    var weights_ih: Array2D  
    var weights_ho: Array2D  
    var bias_h: Array  
    var bias_o: Array  
    var activation_function: Int

    fn __init__(inout self, input_nodes: Int, hidden_nodes: Int, output_nodes: Int, activation_function: Int):
        self.weights_ih = Array2D(hidden_nodes, input_nodes)
        self.weights_ho = Array2D(output_nodes, hidden_nodes)
        self.bias_h = Array(hidden_nodes)
        self.bias_o = Array(output_nodes)
        self.activation_function = activation_function

        for i in range(self.weights_ih.len()):
            self.weights_ih[i] = random_float64() * 2 - 1
        for i in range(self.weights_ho.len()):
            self.weights_ho[i] = random_float64() * 2 - 1
        for i in range(self.bias_h.len()):
            self.bias_h[i] = random_float64() * 2 - 1
        for i in range(self.bias_o.len()):
            self.bias_o[i] = random_float64() * 2 - 1

    fn feed_forward(self, inputs: Array) -> Array:
        var hidden = Array(self.bias_h.len())
        for i in range(hidden.len()):
            var sum: Float64 = 0
            for j in range(inputs.len()):
                sum += inputs[j] * self.weights_ih[i, j]
            hidden[i] = self.activation(sum + self.bias_h[i])

        var outputs = Array(self.bias_o.len())
        for i in range(outputs.len()):
            var sum: Float64 = 0
            for j in range(hidden.len()):
                sum += hidden[j] * self.weights_ho[i, j]
            outputs[i] = self.activation(sum + self.bias_o[i])

        return outputs

    fn activation(self, x: Float64) -> Float64:
        if self.activation_function == 0:
            return self.sigmoid(x)
        elif self.activation_function == 1:
            return tanh(x)
        else:
            return self.relu(x)

    fn activation_derivative(self, x: Float64) -> Float64:
        if self.activation_function == 0:
            return self.sigmoid_derivative(x)
        elif self.activation_function == 1:
            return self.tanh_derivative(x)
        else:
            return self.relu_derivative(x)

    fn sigmoid(self, x: Float64) -> Float64:
        return 1.0 / (1 + exp(-x))

    fn sigmoid_derivative(self, x: Float64) -> Float64:
        var s = self.sigmoid(x)
        return s * (1 - s)

    fn tanh_derivative(self, x: Float64) -> Float64:
        var t = tanh(x)
        return 1 - t * t

    fn relu(self, x: Float64) -> Float64:
        return max(0, x)

    fn relu_derivative(self, x: Float64) -> Float64:
        return 1 if x > 0 else 0

    fn train(self, inputs: Array, targets: Array, learning_rate: Float64):
        var hidden = Array(self.bias_h.len())
        for i in range(hidden.len()):
            var sum: Float64 = 0
            for j in range(inputs.len()):
                sum += inputs[j] * self.weights_ih[i, j]
            hidden[i] = self.activation(sum + self.bias_h[i])

        var outputs = Array(self.bias_o.len())
        for i in range(outputs.len()):
            var sum: Float64 = 0
            for j in range(hidden.len()):
                sum += hidden[j] * self.weights_ho[i, j]
            outputs[i] = self.activation(sum + self.bias_o[i])

        var output_errors = Array(outputs.len())
        for i in range(outputs.len()):
            output_errors[i] = targets[i] - outputs[i]

        var hidden_errors = Array(hidden.len())
        for i in range(hidden.len()):
            var error: Float64 = 0
            for j in range(outputs.len()):
                error += output_errors[j] * self.weights_ho[j, i]
            hidden_errors[i] = error

        for i in range(self.weights_ho.rows()):
            for j in range(self.weights_ho.columns()):
                var delta = learning_rate * output_errors[i] * self.activation_derivative(outputs[i]) * hidden[j]
                self.weights_ho[i, j] += delta
            self.bias_o[i] += learning_rate * output_errors[i] * self.activation_derivative(outputs[i])

        for i in range(self.weights_ih.rows()):
            for j in range(self.weights_ih.columns()):
                var delta = learning_rate * hidden_errors[i] * self.activation_derivative(hidden[i]) * inputs[j]
                self.weights_ih[i, j] += delta
            self.bias_h[i] += learning_rate * hidden_errors[i] * self.activation_derivative(hidden[i])

fn get_activation_name(index: Int) -> String:
    if index == 0:
        return "Sigmoid"
    elif index == 1:
        return "Tanh"
    else:
        return "ReLU"

fn main():
    seed(now())
    
    var X = Array2D(8, 3)
    var Y = Array2D(8, 3)  # 3 outputs for AND, OR, XOR

    X[0, 0] = 0; X[0, 1] = 0; X[0, 2] = 0
    X[1, 0] = 0; X[1, 1] = 0; X[1, 2] = 1
    X[2, 0] = 0; X[2, 1] = 1; X[2, 2] = 0
    X[3, 0] = 0; X[3, 1] = 1; X[3, 2] = 1
    X[4, 0] = 1; X[4, 1] = 0; X[4, 2] = 0
    X[5, 0] = 1; X[5, 1] = 0; X[5, 2] = 1
    X[6, 0] = 1; X[6, 1] = 1; X[6, 2] = 0
    X[7, 0] = 1; X[7, 1] = 1; X[7, 2] = 1

    Y[0, 0] = 0; Y[0, 1] = 0; Y[0, 2] = 0
    Y[1, 0] = 0; Y[1, 1] = 1; Y[1, 2] = 1
    Y[2, 0] = 0; Y[2, 1] = 1; Y[2, 2] = 1
    Y[3, 0] = 0; Y[3, 1] = 1; Y[3, 2] = 0
    Y[4, 0] = 0; Y[4, 1] = 1; Y[4, 2] = 1
    Y[5, 0] = 0; Y[5, 1] = 1; Y[5, 2] = 0
    Y[6, 0] = 0; Y[6, 1] = 1; Y[6, 2] = 1
    Y[7, 0] = 1; Y[7, 1] = 1; Y[7, 2] = 0

    var input_nodes = 3
    var hidden_nodes = 4
    var output_nodes = 3
    var learning_rate = 0.1
    var epochs = 10000

    for af in range(3):
        print("\nTraining with", get_activation_name(af), "activation function:")
        var network = NeuralNetwork(input_nodes, hidden_nodes, output_nodes, af)

        for epoch in range(epochs):
            var total_error: Float64 = 0
            for i in range(X.rows()):
                var inputs = Array(3)
                var targets = Array(3)
                for j in range(3):
                    inputs[j] = X[i, j]
                    targets[j] = Y[i, j]
                
                network.train(inputs, targets, learning_rate)

                var outputs = network.feed_forward(inputs)
                for j in range(3):
                    total_error += (targets[j] - outputs[j]) ** 2

            if epoch % 1000 == 0:
                print("Epoch", epoch, "Error:", total_error / (X.rows() * 3))

        print("\nPredictions:")
        print("A B C | AND OR XOR")
        print("--------------------")
        for i in range(X.rows()):
            var inputs = Array(3)
            for j in range(3):
                inputs[j] = X[i, j]
            var outputs = network.feed_forward(inputs)
            print(inputs[0].__int__(), inputs[1].__int__(), inputs[2].__int__(), "|", 
                  (outputs[0] > 0.5).__int__(), " ", 
                  (outputs[1] > 0.5).__int__(), " ", 
                  (outputs[2] > 0.5).__int__())