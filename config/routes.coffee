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
  app.put    '/:repo',       RepoEvent.save
  app.post   '/:repo',       RepoEvent.edit
  app.delete '/:repo',       RepoEvent.delete

  # Pages
  app.get    '/:repo/:page', PageEvent.show
  app.put    '/:repo/:page', PageEvent.save
  app.post   '/:repo/:page', PageEvent.edit
  app.delete '/:repo/:page', PageEvent.delete

  # [GET]    natsume.com/増井研/合宿2013春
  # [POST]   natsume.com/増井研/合宿2013春
  # [DELETE] natsume.com/増井研/合宿2013春
