module.exports = (app) ->

  RepoEvent = app.get('events').RepoEvent app

  app.get '/', RepoEvent.index