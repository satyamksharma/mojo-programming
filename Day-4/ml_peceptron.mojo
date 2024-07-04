from random import random_float64, seed
from math import exp
from time import now


struct Array:
    var data: Pointer[Float64] #pointer to array data i.e dynamically created
    var size: Int   #size of the array

    fn __init__(inout self, size: Int): #create a constructor (empty array)
        self.size = size
        self.data = Pointer[Float64].alloc(self.size) #allocate memory for the given size

    fn __init__(inout self, size: Int, default_value:Float64): #another constructor that initialize the value of this array 
        self.size = size
        self.data = Pointer[Float64].alloc(self.size)
        for i in range(self.size):  # initialize the array with default value 
            self.data.store(i,default_value)

    fn __copyinit__(inout self, copy: Array): #copy constructor that create a deep copy of this array
        self.size = copy.size
        self.data = Pointer[Float64].alloc(self.size)
        for i in range(self.size):
            self.data.store(i, copy[i])

    fn __getitem__(self,i:Int) -> Float64: # to get an item from specific index
        return self.data.load(i)

    fn __setitem__(self, i: Int, value: Float64): # get the item from get function
        self.data.store(i,value)

    fn __del__(owned self): #destructor to free our memory
        self.data.free()   

    fn len(self) -> Int: # to return the length of the array
        return self.size

struct Array2D:  # this array stores the input and output of the neurons
    var data: Pointer[Float64]  
    var sizeX: Int #no. of rows
    var sizeY: Int #no. of columns

    fn __init__(inout self, sizeX:Int, sizeY: Int):  #CONSTRUCTOR TO ALLOCATE MEMORY AND INITIALIZE THE SIZE OF THIS ARRAY
        self.sizeX = sizeX
        self.sizeY = sizeY
        self.data = Pointer[Float64].alloc(self.sizeX*sizeY) #initilaize empty 2 d array

    fn __init__(inout self, sizeX: Int, sizeY:Int, default_value:Float64): #this constructor will initialize this array with default value
        self.sizeX = sizeX
        self.sizeY = sizeY
        self.data = Pointer[Float64].alloc(self.sizeX*sizeY)
        for i in range(self.sizeX*self.sizeY):
            self.data.store(i,default_value)

    fn __copyinit__(inout self, copy:Array2D): # to have a deep copy of this structure
        self.sizeX = copy.sizeX
        self.sizeY = copy.sizeY
        self.data = Pointer[Float64].alloc(self.sizeX*self.sizeY)
        for i in range(self.sizeX*self.sizeY):
            self.data.store(i, copy[i])
# 2 getitems one for row and column
    fn __getitem__(self, i:Int, j: Int) -> Float64:
        return self[self.sizeY * i + j]

    fn __getitem__(self, i: Int) -> Float64:
        return self.data.load(i)

    fn __setitem__(self, i:Int,value:Float64): #loading the data in the specified index
        self.data.store(i,value)

    fn __setitem__(self, i: Int, j:Int, value:Float64):
        self[self.sizeY*i + j] = value

    fn __del__(owned self): #destructor
        self.data.free()

    fn len(self) -> Int:    #returns length of array
        return self.sizeX*self.sizeY

    fn rows(self) -> Int:  #this method get the rows and column
        return self.sizeX

    fn columns(self) -> Int:
        return self.sizeY

struct NeuralNetwork:      #this network will intialize the weights and bias values
    var weights: Array
    var bias: Array

    fn __init__(inout self): #when new neural nw object will create this will invoke
        self.weights = Array(6)
        self.bias = Array(3)

        for i in range(6): #initialize with random values
            if i < 3:
                self.bias[i] =random_float64()

            self.weights[i] = random_float64()

    fn sigmoid_activation_function(self, x: Float64) -> Float64: 
        return 1.0/(1+exp(-x))

    fn feed_forward(self, x0: Float64,x1:Float64, only_predict: Bool = True) -> Array: #flag to check the final or intermediate predictions
        var hidden0 : Float64 = x0 *self.weights[0] + x1*self.weights[1] + self.bias[0] #x0*W0 + x1*w1 +b0
        var hidden1 : Float64 = x0 * self.weights[2] + x1* self.weights[3] +self.bias[1]
        var output0 : Float64 = x0 * self.weights[4] + x1* self.weights[5] + self.bias[2]

        var sigmoid_hidden0: Float64 = self.sigmoid_activation_function(hidden0)
        var sigmoid_hidden1: Float64 = self.sigmoid_activation_function(hidden1)
        var sigmoid_output0: Float64 = self.sigmoid_activation_function(output0)

        if only_predict:  #used the flag if only_predict true then final output would be displayed
            return Array(1, sigmoid_output0)

        var t = Array(6) #intermediate values would be initialized if not the final prediction
        t[0] = hidden0
        t[1] = sigmoid_hidden0
        t[2] = hidden1
        t[3] = sigmoid_hidden1
        t[4] = output0
        t[5] = sigmoid_output0

        return t 

    fn mse_loss(self, y: Float64, y_true: Float64) -> Float64: #loss is calculated with actaul and predicted values
        return (y - y_true) ** 2

    fn derivation_sigmoid_activation_function(self, x: Float64) -> Float64: #calculates the AF derivative it is essential for gradient decent to make the model learn effectively
        return self.sigmoid_activation_function(x) *(1-self.sigmoid_activation_function(x))

    fn fit(self, X: Array2D, Y:Array, learning_rate:Float64, epochs: Int): #back-propagation
        for i in range(epochs): #for each datasample a feed forward n/w and will update wweiths with backnpropagation
            for j in range(X.rows()):
                var y = self.feed_forward(X[j, 0], X[j, 1], False) # only_predict is false foe intermediate calculation
                var hidden0 = y[0]
                var sigmoid_hidden0 = y[1]
                var hidden1 = y[2]
                var sigmoid_hidden1 = y[3]
                var output0 = y[4]
                var sigmoid_output0 = y[5]
               #calculate the derivatives of weights and and bias
                var derivation_weight_0 = self.weights[0]* self.derivation_sigmoid_activation_function(hidden0)
                var derivation_weight_1 = self.weights[1] * self.derivation_sigmoid_activation_function(hidden0)

                var derivation_weight_2 = self.weights[2]* self.derivation_sigmoid_activation_function(hidden1)
                var derivation_weight_3 = self.weights[3] * self.derivation_sigmoid_activation_function(hidden1)

                var derivation_weight_4 = sigmoid_hidden0 * self.derivation_sigmoid_activation_function(output0)
                var derivation_weight_5 = sigmoid_hidden1 * self.derivation_sigmoid_activation_function(output0)

                var derivation_bias_0 = self.derivation_sigmoid_activation_function(hidden0)
                var derivation_bias_1 = self.derivation_sigmoid_activation_function(hidden1)
                var derivation_bias_2 = self.derivation_sigmoid_activation_function(output0)

                var derivation_hidden_0 = self.weights[4] * self.derivation_sigmoid_activation_function(output0)
                var derivation_hidden_1 = self.weights[5] * self.derivation_sigmoid_activation_function(output0)

                var derivation_mean_square_error = -2 * (Y[j] - y[5])#error w.r.t derivative true output value and the predicted value
                # updation of weights and bias in the oposite direction with learning rate
                self.weights[0] -= learning_rate* derivation_mean_square_error * derivation_hidden_0 * derivation_weight_0
                self.weights[1] -= learning_rate* derivation_mean_square_error * derivation_hidden_0 * derivation_weight_1
                self.weights[2] -= learning_rate* derivation_mean_square_error * derivation_hidden_1 * derivation_weight_2
                self.weights[3] -= learning_rate* derivation_mean_square_error * derivation_hidden_1 * derivation_weight_3

                self.weights[4] -= learning_rate * derivation_mean_square_error * derivation_weight_4
                self.weights[5] -= learning_rate * derivation_mean_square_error * derivation_weight_5

                self.bias[0] -= learning_rate * derivation_mean_square_error * derivation_hidden_0 * derivation_bias_0
                self.bias[1] -= learning_rate * derivation_mean_square_error * derivation_hidden_1 * derivation_bias_1
                self.bias[2]  -= learning_rate * derivation_mean_square_error *  derivation_bias_2

                if i %10 == 0: #periodically printing loss and predictions to monitor the progress
                    var mse: Float64 = 0.0
                    for j in range(X.rows()):
                        var y = self.feed_forward(X[j, 0], X[j, 1], True)
                        mse += self.mse_loss(y[0], Y[j])

                        print(X[j, 0].__int__(), X[j, 1].__int__(), ((y[0] > 0.5).__int__()))

                        print( "Epoch ", i, " loss = ", mse/X.rows())




fn main():

    seed(now()) # to get diifernet result we used seed function and to get current time stamp we used now() 
    var X: Array2D = Array2D(4, 2) #input with 2 features
    var Y: Array = Array(4,1) #target output

    # 0 And 0 -> 0
    # 0 And 1 -> 0
    # 1 And 0 -> 0
    # 1 And 1 -> 1

    X[0,0] = 0
    X[0,1] = 0
    Y[0] = 0

    X[1,0] = 0
    X[1,1] = 1
    Y[1] = 0

    X[2,0] = 1
    X[2,1] = 0
    Y[2] = 0

    X[3,0] = 1
    X[3,1] = 1
    Y[3] = 1

    var network = NeuralNetwork()
    network.fit(X, Y, 0.1, 10000) #calling the fit method with input,target,learning rate and epoch values

    print("Predictions")
    for i in range(4):
        var result = network.feed_forward(X[i, 0], X[i, 1]) 

        print(X[i, 0].__int__(), X[i, 1].__int__(), (result[0] > 0.5).__int__())