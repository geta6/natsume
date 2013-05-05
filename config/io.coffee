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