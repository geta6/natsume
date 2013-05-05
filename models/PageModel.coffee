###
@title  ページ名、全Repoで共通のスキーマを使うのでuniqueじゃない
@repos  親レポ、populateしてください
@html   コンパイル済、presaveでオートハンドルします
@text   未コンパイル、ここにテキストを入れて保存します
@logs   今までの編集履歴、最後が一番新しい
@view   いつ見られたか
  @user   username、デフォルト値はanonymous
  @date   Date.now()
###

Mongo = require 'mongoose'
marked = require 'marked'

PageSchema = new Mongo.Schema
  title: { type: String, index: yes }
  repos: [{ type: Mongo.Schema.Types.ObjectId, ref: 'repos' }]
  html: { type: String, default: '' }
  text: { type: String, default: '' }
  logs: [{ type: Mongo.Schema.Types.Mixed }]
  created: { type: Date, default: Date.now() }
  updated: { type: Date, default: Date.now() }

PageSchema.pre 'save', (done) ->
  @logs.push @text
  @html = marked @text
  @updated = Date.now()
  return @save done

PageSchema.path('logs').validate (log) ->
  return no if typeof log isnt 'object'
  console.log log
  return no if (key isnt 'user' and key isnt 'date') for key of log
  return yes

exports.Page = Mongo.model 'pages', PageSchema
