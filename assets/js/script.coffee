console.log 'coffee'

console.log window.location.pathname
repo = (window.location.pathname.split "/")[1]
page = (window.location.pathname.split "/")[2]

sio = io.connect("/#{repo}?repo=#{repo}")
socket = sio.socket

socket.of("/#{repo}")

  # 接続失敗
  .on 'connect_failed', (reason)->
    console.log "error:#{reason}"

  # 接続成功
  .on 'connect', ->
    console.log "socket.io connected"
    sio.emit 'join page', page if page

  # 同ページで編集が行われた
  .on 'sync', (data)->
    console.log 'sync'
    console.log data
  # 同repoで編集が行われた
  .on 'update', (data) ->
    console.log 'update'
    console.log data
