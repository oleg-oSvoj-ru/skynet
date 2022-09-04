NN   = require './NN'

nn = new NN(2, 4, 1);

input  = [[0,0], [0,1], [1,0], [1,1]]
target = [[0], [1], [1], [0]]


test   = [[0.5,0.5]]

console.log '==============================================='
console.dir nn.predict(test)
console.log '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
nn.train(input, target)
console.log '==============================================='
console.dir nn.predict(test)
