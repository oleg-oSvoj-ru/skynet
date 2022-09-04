class NeuralNetwork
    constructor: (...args)->
        @.input_nodes  = args[0]
        @.hidden_nodes = args[1]
        @.output_nodes = args[2]
        @.lib          = require './lib'
        @.epochs       = 50000
        @.activation   = @.lib.sigmoid
        @.lr           = .5
        @.output       = 0

        #generate synapses
        @.synapse0 = @.lib.m.random([@.input_nodes,  @.hidden_nodes], -1.0, 1.0)
        @.synapse1 = @.lib.m.random([@.hidden_nodes, @.output_nodes], -1.0, 1.0)
    setEpochs: (numEpochs)->
        @.epochs = numEpochs
    setLearningRate: (lr)->
        @.lr = lr
    setActivation: (func)->
        switch func
            when 'tanh'
                @.activation = @.lib.tanh
            when 'relu'
                @.activation = @.lib.relu
            when 'softplus'
                @.activation = @.lib.softplus
            else
                @.activation = @.lib.sigmoid
    train: (input, target)->
        input_layer  = @.lib.m.matrix input
        obj = @
        for i in [0..@.epochs]
            hidden_layer_logits    = @.lib.m.multiply input_layer, @.synapse0
            hidden_layer_activated = hidden_layer_logits.map (v)->
                obj.activation(v, false)
            output_layer_logits    = @.lib.m.multiply hidden_layer_activated, this.synapse1
            output_layer_activated = output_layer_logits.map (v)->
                obj.activation(v, false)

            output_error = @.lib.m.subtract @.lib.m.matrix(target), output_layer_activated

            output_delta = @.lib.m.dotMultiply output_error, output_layer_logits.map (v)->
                obj.activation(v, true)
            hidden_error = @.lib.m.multiply    output_delta, @.lib.m.transpose(this.synapse1)
            hidden_delta = @.lib.m.dotMultiply hidden_error, hidden_layer_logits.map (v)->
                obj.activation(v, true)

            @.synapse1 = @.lib.m.add @.synapse1, @.lib.m.multiply(@.lib.m.transpose(hidden_layer_activated), @.lib.m.multiply(output_delta, @.lr))
            @.synapse0 = @.lib.m.add @.synapse0, @.lib.m.multiply(@.lib.m.transpose(input_layer), @.lib.m.multiply(hidden_delta, @.lr))
            @.output = output_layer_activated

            if i % 10000 == 0
                console.log 'Error: ' + @.lib.m.mean(@.lib.m.abs(output_error))


    predict: (input)->
        obj = @
        input_layer  = @.lib.m.matrix input
        hidden_layer = @.lib.m.multiply(input_layer, @.synapse0).map (v) ->
                    obj.activation(v, false)
        output_layer = @.lib.m.multiply(hidden_layer, @.synapse1).map (v)->
                    obj.activation(v, false)
        return output_layer;
module.exports = NeuralNetwork
