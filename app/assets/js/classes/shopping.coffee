class ShoppingController

  constructor: ($scope, $location) ->
    @$scope = $scope
    @$scope.bill = {}
    @pathOriign = window.location.origin
    @ajaxRoute = "#{@pathOriign}/services/coffee"
    
    # intialize our class
    @init()

  _getCoffees: =>
    # we are getting our coffees 
    # -- imagine if these values or items were coming from a server
    @$scope.items = [
      {title: 'New Orleans Iced', quantity: 1, price: 3.75}
      {title: 'Drip Coffee', quantity: 1, price: 2.75}
      {title: 'Hayes Valley Espresso', quantity: 1, price: 5.95}
    ]
    
  init: =>
    # we could get the data in our controller -- for a small application it wont be bad
    # however for larger apps it may get ugly
    #@_getCoffees()
    @$scope.$watch('items', @calculateTotals, true)

    # -- OR --
    # we can run watch everytime Angular evaluates a page which can 
    # help performance on larger items.
    # ----------------------------
    #@$scope.$watch( =>
      #console.log 'test'
      #total = 0
      #for item in @$scope.items
        #total = total + item.price * item.quantity

      ## pass all our values to the $scope object
      #@$scope.bill.totalCart = total
      #@$scope.bill.discount = if total > 100 then 10 else 0
      #@$scope.bill.subtotal = total - @$scope.bill.discount
      
    #)

  calculateDiscount: (newValue, oldValue, scope) =>
    @$scope.bill.discount = if (newValue > 100) then 10 else 0
    console.log @$scope.bill.discount

  calculateTotals: =>
    total = 0
    for item in @$scope.items
      total = total + item.price * item.quantity

    # pass all our values to the $scope object
    @$scope.bill.totalCart = total
    @$scope.bill.discount = if total > 100 then 10 else 0
    @$scope.bill.subtotal = total - @$scope.bill.discount


  subtotal: =>
    return @totalCart() - @$scope.bill.discount
    
  remove: (index) =>
    @$scope.items.splice(index, 1)

# kicking it old school
# AngularDemo.App._Angular.controller('ShoppingController', ShoppingController)

# New method of calling our controller, we need to retrieve our factory
# model which has our data
AngularDemo.App._Angular.controller('ShoppingController', ['$scope', 'Items', (@$scope, Items) =>
  # We get our data from the model
  @$scope.items = Items.items.query()
  # Initialize our main controller
  new ShoppingController(@$scope)
])
