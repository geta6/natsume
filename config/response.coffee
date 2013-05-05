module.exports = (req, res, next) ->

  res.api = (code = 200, body = {}, message = null) ->
    if body.message
      message = body.message
      delete body.message
    unless message
      switch code
        when 200 then message = 'OK'
        when 201 then message = 'Created'
        when 204 then message = 'No Content'
        when 302 then message = 'Found'
        when 400 then message = 'Bad Request'
        when 401 then message = 'Unauthorized'
        when 403 then message = 'Forbidden'
        when 404 then message = 'Not Found'
        when 500 then message = 'Internal Server Error'
        when 503 then message = 'Service Unavailable'
        else          message = 'Unknown'

    res.jsonp code,
      head:
        stat: if 400 > code then 'success' else 'failure'
        type: req.method
        method: if req.route then req.route.path else ''
        message: message
      body: body

  next()