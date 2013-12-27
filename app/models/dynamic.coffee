class DataModel
  constructor: ->
    @id = Math.random().toString(36).substr(2, 8)
    @purchases = {}
    @purchases.id = @id
    @purchases.coffee_purchases = 0

    @init()

  _addPurchases: (amount) =>
    purchases = @purchases.coffee_purchases
    newAmount = purchases + amount
    @purchases.coffee_purchases = newAmount

  _getPurchases: =>
    return @purchases

  randomInt: (low, high) =>
    return low + Math.floor(Math.random() * (high - low))
    
  init: =>
    console.log 'test'.green
    setInterval( =>
      val = @randomInt(0,5)
      @_addPurchases(val)
    , 500)

#DataModel = new DataModel
module.exports = new DataModel
