class ShoppingData

  constructor: ($scope, $location) ->
    @$scope = $scope
    @items = {}

    @init()

  init: =>
    @$win = $(window)

    @getCoffeeData()

  getCoffeeData: =>
    @items.query = =>
      return [
        {title: 'New Orleans Iced', quantity: 1, price: 3.75}
        {title: 'Drip Coffee', quantity: 1, price: 2.75}
        {title: 'Hayes Valley Espresso', quantity: 1, price: 5.95}
      ]

    return @items.query

AngularDemo.App._Angular.factory('Items', => new ShoppingData)
