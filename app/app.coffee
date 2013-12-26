express       = require 'express'
http          = require 'http'
colors        = require('colors')
sass          = require('node-sass')
compass       = require('node-compass')
path          = require('path')
#conf          = require '../conf'

PORT = 8000
PORT_TEST = PORT + 1

app = express(
  express.bodyParser(),
  express.cookieParser(),
  express.session({ secret: 'esoognom'})
)

app.configure ->
  app.set 'port', process.env.PORT or PORT
  app.set 'views', "#{__dirname}/views"
  app.set 'view engine', 'jade'
  app.use express.favicon()
  app.use express.logger('dev') if app.get('env') is 'development'
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use require('connect-assets')(src: "#{__dirname}/assets")
  app.use express.cookieParser()
  app.use compass({
     project:  path.join(__dirname, 'assets')
     sass:  path.join(__dirname, 'assets/sass')
     css:  path.join(__dirname, 'public/css')
     cache: false
     logging: true
  })
  app.use express.static "#{__dirname}/public"
  app.use express.session({secret: 'whodunnit'})
  require('./middleware/404')

app.configure 'development', ->
  app.use express.errorHandler()
  app.locals.pretty = true

app.configure "test", ->
  app.set 'port', PORT_TEST

console.log '-- STARTING APPLICATION --'.green

autoload = require('./config/autoload')(app)
autoload "#{__dirname}/helpers", true
autoload "#{__dirname}/assets/js/shared", true
autoload "#{__dirname}/models"
autoload "#{__dirname}/controllers"

console.log '-- RETRIEVED ALL ASSETS --'.green

require('./config/routes')(app)

## Startup the app
http.createServer(app).listen app.get('port'), ->
  port = app.get 'port'
  env = app.settings.env
  console.log "listening on port #{port} in #{env} mode"

module.exports = app

#dbConnection = new DatabaseModel()
