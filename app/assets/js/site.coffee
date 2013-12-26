window.AngularDemo =
  models: {}
  views: {}
  App: {
    # We've essentially told ng-app about our `ad` app
    # also told angular to make a module with our ad name.
    _Angular: angular.module("ad", []).config ($locationProvider) ->
      $locationProvider.html5Mode true
    _UserData: {}
  }
