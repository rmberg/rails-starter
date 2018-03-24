process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment')
const custom = require('./custom')

environment.config.merge(custom)
module.exports = environment.toWebpackConfig()
