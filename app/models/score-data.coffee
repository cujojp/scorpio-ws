mongo = require('mongodb').MongoClient
pusherClient = require('pusher-node-client').PusherClient

module.exports = (app) =>
  {pathFor} = app.locals.path
  class ConnectDataModel
    constructor: ->
      @database         = null
      @dbCollection     = null
      @dbConf           = app.get('_mongoUser')

      @init()

    _connectDb: =>
      console.log '-- CONNECTING TO MONGO --'.green
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

    _initializeBindings: =>
     
      pusher_client = new pusherClient
        appId: @dbConf._pid
        key: @dbConf._pkey
        secret: @dbConf._psecret

      console.log pusher_client
      pres = null
      pusher_client.on 'connect', () =>
        pres = pusher_client.subscribe("scorpio_event")

        pres.on 'success', () =>
          pres.on 'update', (data) =>
            @_getCollection()

      pusher_client.connect()

    init: =>
      @_connectDb()
      @_initializeBindings()


  module.exports = new ConnectDataModel
