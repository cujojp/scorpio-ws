class ScorpioSockets

  constructor: ->
    @init()

  init: =>
    @window = $(window)
    @document = $(document)

    ## DO NOT INCLUDE THIS IN PRODCTION
    #Pusher.log = (message) =>
      #if (window.console && window.console.log)
        #window.console.log(message)

    @pusher = new Pusher('3ea910de3b4179ff0d0e')
    @channel = @pusher.subscribe('scorpio_event')

    @_bindListeners()
  
  _bindListeners: =>
    @channel.bind('update', (event) =>
      
      console.log 'event'
      @document.trigger(
        'score-update',
        [ event ]
      )
    )

Scorpio.App.ScorpioSockets = ScorpioSockets
