console.log 'coffee'

console.log window.location.pathname
repo = (window.location.pathname.split "/")[1]
page = (window.location.pathname.split "/")[2]
socket = io.connect('/?repo=#{repo}&page=#{page}')