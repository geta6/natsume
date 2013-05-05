RedisStore = require('socket.io/lib/stores/redis')
redis = require('socket.io/node_modules/redis')
pub = redis.createClient()
sub = redis.createClient()
client = redis.createClient()

module.exports = (app, server) ->
  io = (require 'socket.io').listen server
  io.set 'store', new RedisStore
    redisPub: pub
    redisSub: sub
    redisClient: client

  # ここにio実装
  io.sockets.on 'connection', (socket) ->

    socket.on 'join', (path)->
      socket.join path.repo
      socket.set 'repo', path.repo
      if path.page
        socket.join path.page
        socket.set 'page', path.page


