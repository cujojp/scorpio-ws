module.exports = (app) ->
  {pathFor} = app.locals.path

  console.log '-- AngularHello --'.green
  class AngularHello
    @first = (req, res) ->
      console.log ' -- FIRST --'.green
      res.render('intro/first', view: 'angular_intro')

    @second = (req, res) ->
      console.log ' -- SECOND --'.green
      res.render('intro/second', view: 'angular_coffee')

    @shopping = (req, res) ->
      console.log ' -- NEW --'.green
      res.render('shopping/cart', view: 'shopping')

    @create = (req, res) ->
      console.log ' -- CREATE --'.green

