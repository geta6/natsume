exports.RepoEvent = (app) ->

  {Repo} = app.get 'models'

  show: (req, res) ->
    # Repoを表示する
    Repo.findByTitle req.params.repo, (err, repo) ->
      res.render 'repo-view', repo

  save: (req, res) ->
    # 編集されたRepoの情報を保存する
    Repo.findByTitle req.params.repo, (err, repo) ->
      # repo.claim = app.get('helper').shasum req.body.password
      repo.save (err, repo) ->
        console.error err if err
        res.render 'repo-view', repo

  edit: (req, res) ->
    # Repoのエディタを表示する
    Repo.findByTitle req.params.repo, (err, repo) ->
      res.render 'repo-edit', repo

  delete: (req, res) ->
    # Repoを削除する
    Repo.findByTitle req.params.repo, (err, repo) ->
      repo.remove (err) ->
        console.error err if err
        res.redirect '/'

