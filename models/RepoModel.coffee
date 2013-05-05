###
@title  リポジトリ名、ユニーク()
@index  インデックスとして評価するページ名
@pages  PageModelのObjectId
@claim  sha1でシリアライズしたパスワード
@limit  いつclaimするか
  "view"  閲覧するのにパスワードが必要
  "edit"  編集するのにパスワードが必要
  "open"  view・edit以外、閲覧も編集も自由
###

Mongo = require 'mongoose'

RepoSchema = new Mongo.Schema
  title: { type: String, unique: yes, index: yes }
  index: { type: String, default: 'index' }
  pages: [{ type: Mongo.Schema.Types.ObjectId, ref: 'pages' }]
  claim: { type: String, default: '' }
  limit: { type: String, default: '' }

RepoSchema.statics.findByTitle = (title, done) ->
  @findOne title: title, {}, {}, (err, repo) ->
    console.error err if err
    return done err, repo

RepoSchema.statics.findPage = (repotitle, pagetitle, done) ->
  @findOne title: repotitle, {}, { populate: 'pages' }, (err, repo) ->
    console.error err if err
    return done err, (_.find repo.pages), (page) ->
      return page.title is pagetitle

RepoSchema.path('limit').validate (limit) ->
  return no if limit isnt 'view' and limit isnt 'edit' and limit isnt 'open'
  return yes

exports.Repo = Mongo.model 'repos', RepoSchema
