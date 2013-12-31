ejs = require 'ejs'

module.exports = (app) ->
  {pathRaw} = app.locals.path
  @App = app.locals

  app.get pathRaw('index'), (req, res) ->
    res.render 'index'

  app.get "/js/data.js", (req, res) ->
    res.set 'content-type', 'application/json'
    res.render 'scoreData', { data : app.locals.scoredata }

  app.get "/details/:slug", (req, res) ->
    user = req.params.slug
    data = JSON.parse(app.locals.scoredata)

    for obj, i in data
      userName = obj._user
      if user.toLowerCase() == userName.toLowerCase()
        res.render('userData', { data : obj })
        break
      else if (i+1 == data.length)
        res.render('404', { status: 404, url: userName })
        break
    
