exports.RepoEvent = (app) ->

  {Repo} = app.get('models')

  index: (req, res) ->
    res.render 'index', {}

  json:
    create: (req, res) ->
      return res.end 'hoge'
      # title = req.body.title
      # return (res.json 400, error) unless req.body.title?
      # Repo.findByTitle
      # new Repo

      # req.body.index or= 'index'
      # req.body.pages = []
      # req.body.claim = ''
      # return (res.json 400, error)
      # return (res.json 400, error) unless req.body.pages?
      # return (res.json 400, error) unless req.body.title?
