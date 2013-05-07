express = require 'express'

module.exports = (app) ->

  SiteEvent = app.get('events').SiteEvent app
  RepoEvent = app.get('events').RepoEvent app
  PageEvent = app.get('events').PageEvent app

  {Repo} = app.get('models')

  claim = (req, res, next) ->
    # intercept basicAuth process
    Repo.findByTitle req.params.repo, (err, repo) ->
      return next() unless repo
      if repo.limit is 'open'
        return next()
      if repo.limit is 'edit'
        return next() if req.method.toUpperCase() is 'GET'
      (express.basicAuth (username, password) ->
        password = app.get('helper').shasum _.str.trim password
        return password is repo.claim) req, res, next

  # Main Site
  app.get    '/',            SiteEvent.index
  app.get    '/test', (req, res, next) ->


  # app.get    '/about',       SiteEvent.about
  # natsume.com/natsume にリダイレクト

  # Repos
  app.get    '/:repo',       claim, RepoEvent.show
  app.post   '/:repo',       claim, RepoEvent.edit
  app.put    '/:repo',       claim, RepoEvent.save
  app.delete '/:repo',       claim, RepoEvent.delete

  # Pages
  app.get    '/:repo/:page', claim, PageEvent.show
  app.post   '/:repo/:page', claim, PageEvent.edit
  app.put    '/:repo/:page', claim, PageEvent.save
  app.delete '/:repo/:page', claim, PageEvent.delete
