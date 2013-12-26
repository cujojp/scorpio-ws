class Demo1

  constructor: ($location) ->
    @greeting = "Nurun Peep"
    @location = $location
    @hash = @location.url()
    console.log @location.url()
 
    if @hash is '/#coffee'
      @greeting = 'peepz who want coffee'


  greet: ->
    return @greeting

AngularDemo.App._Angular.controller('DemoCtrl', Demo1)
