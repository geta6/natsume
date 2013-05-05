exports.RepoEvent = (app) ->

  {Repo} = app.get 'models'
  {Page} = app.get 'models'

  show: (req, res) ->
    Repo.findByTitle req.params.repo, (err, repo) ->
      unless repo
        return res.render 'repo-view', { req: req, repo: repo, page: null }
      Page.findByTitle repo._id, repo.index, (err, page) ->
        res.render 'repo-view', { req: req, repo: repo, page: page }

  edit: (req, res) ->
    Repo.findByTitle req.params.repo, (err, repo) ->
      return (res.redirect) req.url unless repo
      res.render 'repo-edit', { req: req, repo: repo, page: null }

  save: (req, res) ->
    Repo.findByTitle req.params.repo, (err, repo) ->
      return (res.redirect) req.url unless repo
      # repo.claim = app.get('helper').shasum req.body.password
      repo.save (err, repo) ->
        console.error err if err
        res.render 'repo-view', { req: req, repo: repo, page: null }

  delete: (req, res) ->
    Repo.findByTitle req.params.repo, (err, repo) ->
      return (res.redirect) req.url unless repo
      repo.remove (err) ->
        console.error err if err
        res.redirect '/'

