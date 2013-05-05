Mongo = require 'mongoose'

RepoSchema = new Mongo.Schema
  title: { type: String, unique: yes, index: yes }
  index: { type: String, default: 'index' }
  pages: [{ type: Mongo.Schema.Types.ObjectId, ref: 'pages' }]
  claim: { type: String, default: '' }
  policy: { type: String, default: '' }

# limit: いつclaimするか
#   view: Require password to view
#   edit: Require password to edit
#   open: Everyone can edit

RepoSchema.statics.findByTitle = (title, done) ->
  @findOne title: title, {}, {}, (err, repo) ->
    console.error err if err
    return done err, repo

RepoSchema.statics.findPage = (repotitle, pagetitle, done) ->
  @findOne title: repotitle, {}, { populate: 'pages' }, (err, repo) ->
    console.error err if err
    return done err, (_.find repo.pages), (page) ->
      return page.title is pagetitle

exports.Repo = Mongo.model 'repos', RepoSchema
