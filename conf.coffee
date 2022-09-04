conf =
        base      : ""
        consoleLog: true
        consoleNum: [0]
        user      : ""
        pass      : ""
        host      : ""
        port      : ""










conf.basePatch = 'https://' + conf.user + ':' + conf.pass + '@' + conf.host+':'+conf.port+'/'+conf.base+'/'
conf.base      = 'https://' + conf.host+':'+conf.port+'/'+conf.base+'/'



module.exports = conf
