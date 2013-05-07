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

  io.configure ->
  io.set "authorization", (handshake, callback) ->

    repo = handshake.query.repo
    # namespaceが無い場合に作成する
    unless io.namespaces.hasOwnProperty("/#{repo}")
      namespace = io.of("/#{repo}")

      namespace.on "connection", (socket) ->

        socket.set 'repo', namespace.name

        socket.on 'join page', (page) ->
          socket.join page
          socket.set 'page', page

        socket.on 'sync', (data) ->
          # emit to sockets in same repo
          socket.get 'repo', (err,repo) ->
            io.of("/#{repo}").emit 'update', data
          # emit to sockets in same repo and page
            socket.get 'page', (err,page)->
              io.of("/#{repo}").in(page).emit 'sync', data

        socket.on 'disconnect', ->
          socket.get 'repo', (err,repo) ->
            socket.get 'page', (err,page) ->
              socket.leave page if page # この処理よりも前に既にleaveが終わっている感

              # room内で最後のclientであればsave
              if io.of(repo).clients(page).length is 0
                console.log 'save db'
                #save db

        socket.on 'timeout', (data) ->
          console.log data
          # save db


    # authorization true
    callback null, true
