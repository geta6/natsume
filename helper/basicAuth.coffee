#
# めも: 長いしめんどいし直接書いてもいいかもしれない
#

express = require 'express'

exports.basicAuth = (req, username, password) ->
  {Repo} = req.app.get 'models'
  Repo.findOne {}, {}, (err, repo) ->
    return express.basicAuth (user, pass) ->
      return user is username and pass is password

# app.get '/', (req, res) ->
#   (app.get('helper').basicAuth req, 'pitecan', 'are').apply @, arguments
