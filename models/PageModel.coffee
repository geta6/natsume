Mongo = require 'mongoose'

marked = require 'marked'

PageSchema = new Mongo.Schema
  title: { type: String, index: yes }
  body: { type: String, default: '' }
  text: { type: String, default: '' }
  history: [{ type: String }]
  access: [{ type: Date, default: Date.now() }]
  repos: [{ type: Mongo.Schema.Types.ObjectId, ref: 'repos' }]
  created: { type: Date, default: Date.now() }
  updated: { type: Date, default: Date.now() }

# socketがあるうちはon memory(app.coffeeとかに持たせる)
# socketが全部disconnectしたらsaveする
#   timeoutをもうける
#   2分とか30sとか、何も無ければ保存してmemoryをクリアする

PageSchema.pre 'save', (done) ->
  @history.push @text
  @body = marked @text
  return @body.save done

exports.Page = Mongo.model 'pages', PageSchema
