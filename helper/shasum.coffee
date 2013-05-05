crypto = require 'crypto'

exports.shasum = (source) ->
  return crypto.createHash('sha1').update(source).digest('hex')
