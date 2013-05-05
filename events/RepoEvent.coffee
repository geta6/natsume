exports.RepoEvent = (app) ->

  {Repo} = app.get('models')

  index: (req, res) ->
    res.render 'index', {}
