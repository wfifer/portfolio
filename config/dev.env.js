'use strict'
const merge = require('webpack-merge')
const prodEnv = require('./prod.env')

module.exports = merge(prodEnv, {
  NODE_ENV: '"development"',
  API_BASE: '"https://api.willfifer.com"'
  // API_BASE: '"http://api.portfolio.local"'
})
