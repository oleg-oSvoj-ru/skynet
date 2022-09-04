lib = {}
lib.m  = require 'mathjs'
lib.c  = require './conf'
#lib.db = new require('pouchdb')(lib.c.basePatch)

lib.sigmoid = (x, derivative)->
    fx = 1 / (1 + lib.m.exp(-x))
    if (derivative)
        return fx * (1 - fx)
    return fx

lib.tanh = (x, derivative)->
    fx = 2 / (1 + lib.m.exp(-2 * x)) - 1
    if (derivative)
        return 1 - lib.m.pow(fx, 2)
    return fx

lib.relu = (x, derivative)->
    if (derivative)
        return x < 0 ? 0 : 1
    return x < 0 ? 0 : x

lib.softplus = (x, derivative)->
    if (derivative)
        return 1 / (1 + lib.m.exp(-x))
    return lib.m.log(1 + lib.m.exp(x), lib.m.e)

module.exports = lib
