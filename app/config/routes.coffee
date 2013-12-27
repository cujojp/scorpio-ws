module.exports = (app) ->
  {pathRaw} = app.locals.path
  @App = app.locals

  requireRole = (role) =>
    return (req, res, next) =>
      if(req.session.user and req.session.user.role is role)
        next()
      else
        res.send(403)

  app.get pathRaw('index'), (req, res) ->
    res.render 'index', view: 'index'

  app.get("/first", @App.AngularHello.first)
  app.get("/second", @App.AngularHello.second)
  app.get("/shopping", @App.AngularHello.shopping)
  app.get("/services/coffee", @App.DynamicData.coffee)

  app.get('*', (req, res) =>
    res.render(404)
  )
