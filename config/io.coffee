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

    socket.on 'join', (data)->
      socket.join data.repo
      socket.set 'repo', data.repo
      if data.page
        socket.join data.page
        socket.set 'page', data.page


    socket.on 'sync', (data) ->
      socket.get 'repo', (err,repo) ->
        #同じRepoをwatchしているユーザにemit
        socket.broadcast.to(repo).emit 'update', data
        socket.get 'page', (err,page) ->
          return null if err
          # 同じrepoで同じpageなら?


    socket.on 'disconnect', (data) ->
      # save mongoDB

    socket.on 'timeout', (data) ->
      # save mongoDB

