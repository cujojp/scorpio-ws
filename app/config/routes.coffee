module.exports = (app) ->
  {pathRaw} = app.locals.path
  @App = app.locals

  app.get pathRaw('index'), (req, res) ->
    res.render 'index', view: 'index'
