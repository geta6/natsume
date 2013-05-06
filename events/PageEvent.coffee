exports.PageEvent = (app) ->

  {Repo} = app.get 'models'
  {Page} = app.get 'models'

  async = require 'async'

  show: (req, res) ->
    Repo.findByTitle req.params.repo, (err, repo) ->
      unless repo
        return res.render 'page-view', { req: req, repo: null, page: null }
      Page.findByTitle repo._id, req.params.page, (err, page) ->
        res.render 'page-view', { req: req, repo: repo, page: page }

  edit: (req, res) ->
    Repo.findByTitle req.params.repo, (err, repo) ->
      return (res.redirect) req.url unless repo
      Page.findByTitle repo._id, req.params.page, (err, page) ->
        res.render 'page-edit', { req: req, repo: repo, page: page }

  save: (req, res) ->
    Repo.findByTitle req.params.repo, (err, repo) ->
      unless repo
        repo = new Repo
          title: req.params.repo
          index: req.params.page
          pages: []
          claim: ''
          limit: 'open'
      Page.findByTitle repo._id, req.params.page, (err, page) ->
        unless page
          page = new Page
            title: req.params.page
            repo: repo._id
            text: req.body.text
            logs: [{ user: 'anonymous', date: Date.now() }]
            created: Date.now()
            updated: Date.now()
        page.save (err, page) ->
          repo.pages.push page
          repo.save (err, repo) ->
          console.info repo, page
          res.render 'page-view', { req: req, repo: repo, page: page }

  delete: (req, res) ->
    Repo.findByTitle req.params.repo, (err, repo) ->
      return (res.redirect) req.url unless repo
      Page.findByTitle repo._id, req.params.page, (err, page) ->
        page.remove (err) ->
          console.error err if err
          res.redirect "/#{req.params.repo}"

