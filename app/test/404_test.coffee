request = require 'superagent'
app = require '../app'
util = require './util'

describe '404', ->
  url = util.urlFor '404'
  message = 'page not found'

  it 'should respond with html (accepts html)', (done) ->
    request.get(url).end (res) ->
      res.should.have.status 404
      res.should.be.html
      done()
