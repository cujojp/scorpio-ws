ejs = require 'ejs'

module.exports = (app) ->
  {pathRaw} = app.locals.path
  @App = app.locals

  app.get pathRaw('index'), (req, res) ->
    res.render 'index'

  app.get "/js/data.js", (req, res) ->
    res.set 'content-type', 'application/json'
    res.render 'scoreData', { data : app.locals.scoredata }
