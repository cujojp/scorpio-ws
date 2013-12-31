mongo = require('mongodb').MongoClient

module.exports = (app) =>
  {pathFor} = app.locals.path
  class ConnectDataModel
    constructor: ->
      @database         = null
      @dbCollection     = null
      @dbConf           = app.get('_mongoUser')

      @init()

    _connectDb: =>
      console.log '-- CONNECTING TO MONGO DB --'.green
      @mongoQuery = "mongodb://#{@dbConf._user}:#{@dbConf._secret}@ds031608.mongolab.com:31608/#{@dbConf._appId}"
      @mongoUri = process.env.MONGOLAB_URI || process.env.MONGOHQ_URL || @mongoQuery

      mongo.connect(
        @mongoUri,
        @dbCollection,
        Function.prototype.call.bind(@_dbConnectCallback, @))

    _handleError: (message) =>
      # quality error handling 
      console.log "fuk #{message}".red

    _dbConnectCallback: (error, db) =>
      ## if the db comes back as null || undefined we have a problem
      if (!db || error)
        if (!error) then error = "Database is undefined"
        return @_handleError(error)

      console.log '-- CONNECTED WITH MONGO --'.green

      @database = db
      @dbModel = @database

      @database.collection('users', (error, callback) =>
        if (error)
          @_handleError(error)
        else
          @dbCollection = @database.collection('users')
          @_getCollection()
      )

    _getCollection: =>
      @dbCollection.find().sort({$natural:-1}).toArray((err, results)  =>
        app.locals.scoredata = JSON.stringify(results)
      )

    init: =>
      @_connectDb()


  module.exports = new ConnectDataModel
