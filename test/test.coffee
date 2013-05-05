fs = require 'fs'
path = require 'path'
async = require 'async'
{exec} = require 'child_process'
assert = require 'assert'
supertest = require 'supertest'

app = require path.resolve 'config', 'app'

cookie = {}

authenticate = ->
  beforeEach (done) ->
    request('post /user/signin')
      .send(testuser)
      .expect(200)
      .end (err, res) ->
        console.error err if err
        cookie = res.headers['set-cookie']
        done()

request = (pattern)->
  pattern = pattern.split ' '
  method = pattern.shift().toLowerCase()
  method = if method isnt 'delete' then method else 'del'
  return supertest(app)[method](pattern.join '')

describe 'Test Environment', ->
  it 'should work', (done) ->
    done null, yes
