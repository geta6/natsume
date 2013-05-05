exports.PageEvent = (app) ->

  {Repo} = app.get 'models'

  show: (req, res) ->
    Repo.findPage req.params, (err, page) ->
      res.render 'page-view', page

  save: (req, res) ->
    Repo.findPage req.params, (err, page) ->
      # page.text = req.body.text
      page.save ->
        res.render 'page-view', page

  edit: (req, res) ->
    Repo.findPage req.params, (err, page) ->
      res.render 'page-edit', page

  delete: (req, res) ->
    Repo.findPage req.params, (err, repo) ->
      res.redirect "/#{req.params.repo}"

