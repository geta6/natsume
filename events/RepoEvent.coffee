exports.RepoEvent = (app) ->

  {Repo} = app.get('models')

  index: (req, res) ->
    # return res.end() if req.method.toUpperCase is 'HEAD'
    res.render 'index', {}

  json:
    create: (req, res) ->
      return (res.return 400) unless req.query.title?
      repo = new Repo
        title: req.query.title
        index: 'index'
        pages: []
        claim: ''
        policy: 'open'
      repo.save (err, repo) ->
        return (res.return 201) unless err
        return (res.return 403, {}, 'Already Exists')

    update: (req, res) ->
      return (res.return 400) unless req.query.title?
      repo.title = req.query.title
      repo.index = req.query.index if req.query.index
      repo.claim = req.query.claim if req.query.claim
      repo.policy = req.query.policy if req.query.policy
      repo.save (err, repo) ->
        return (res.return 201) unless err
        return (res.return 403, {}, 'Already Exists')
