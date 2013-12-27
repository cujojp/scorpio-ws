module.exports = (app) ->
  {pathFor} = app.locals.path
  DataModel = require('../models/dynamic')

  console.log '-- DynamicController --'.green
  console.log '-- DataModel --', require('../models/dynamic')
  class DynamicData

    @coffee = (req, res, callback) =>
      purchaseData = DataModel._getPurchases()

      console.log purchaseData
      res.json( purchaseData )
