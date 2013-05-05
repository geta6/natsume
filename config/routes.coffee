module.exports = (app) ->

  SiteEvent = app.get('events').SiteEvent app
  RepoEvent = app.get('events').RepoEvent app
  PageEvent = app.get('events').PageEvent app

  # Main Site
  app.get    '/',            SiteEvent.index
  # app.get    '/about',       SiteEvent.about
  # natsume.com/natsume にリダイレクト

  # Repos
  app.get    '/:repo',       RepoEvent.show
  app.post   '/:repo',       RepoEvent.edit
  app.put    '/:repo',       RepoEvent.save
  app.delete '/:repo',       RepoEvent.delete

  # Pages
  app.get    '/:repo/:page', PageEvent.show
  app.post   '/:repo/:page', PageEvent.edit
  app.put    '/:repo/:page', PageEvent.save
  app.delete '/:repo/:page', PageEvent.delete
