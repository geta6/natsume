exports.PageEvent = (app) ->

  {Repo} = app.get 'models'

  show: (req, res) ->
    res.render 'repos', tmp: 'show'

  save: (req, res) ->
    res.render 'repos', tmp: 'save'

  edit: (req, res) ->
    res.render 'repos', tmp: 'edit'

  delete: (req, res) ->
    res.render 'repos', tmp: 'delete'

