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
  io.configure ->
    # handshake時のnamespaceからroomを分ける
    io.set 'authorization', (handshake,callback) ->
      repo = handshake.query.repo
      page = handshake.query.page
      console.log "repo:#{repo} page:#{page}"

      unless io.namespaces.hasOwnProperty(repo)
        repo = io.of(repo)

        repo.on 'connection', (socket)->
          socket.join socket.handshake.query.page if socket.handshake.query.page

        repo.on 'disconnect', (socket)->
          socket.leave socket.handshake.query.page if socket.handshake.query.page
          # save mongoDB

        repo.on 'timeout', (data)->
          # save mongoDB

        repo.on 'sync', (socket,data)->
          repo.broadcast.emit 'update',data #通知
          repo.broadcast.to(socket.handshake.query.page).emit 'sync',data #同期

      callback(null,true)
