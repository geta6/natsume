exports.SiteEvent = (app) ->

  index: (req, res) ->
    res.render 'index', { req: req, repo: null, page: null }