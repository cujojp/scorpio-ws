views = Scorpio.views

class ScoreList
  constructor: ->
    @win = $(window)
    @document = $(document)
    @obody = $('body')
    @jqMustache = $.Mustache

    ## Get Elements
    @_scoreContainerEl = $('.score-container')
    @_scoreData = null

    @init()



  # init
  #
  # Initializes the entire module
  init: =>
    domReady = =>
      @_initializeBindings()
      Scorpio.scoreController.getTotalScores( (data) =>
        @_scoreData = data 
        @_renderScoreTemplate())
      

    $(domReady)

  # _initializeEvents
  #
  # Initializes our listeners to show notifications 
  # and display the score list.
  _initializeBindings: =>
    ## On a new event we need to update the view with a new score.
    @document.on 'score-update', (event, opt_data) =>
      data = opt_data

      @_showNotification(data)

      # needs to run on a delay since we dont have a callback yet
      # I know, a bit janky.
      setTimeout ( =>
        Scorpio.scoreController.getTotalScores()
      ), 1000
      

      
  # _showNotification
  #
  # Shows the notification on the UI
  # data {Object} our data retrieved from the event
  _showNotification: (data) =>
    notificationFragment = "<h1>Score updated for #{data.user}</h1>"
    @_scoreContainerEl.append(notificationFragment)

    setTimeout ( =>
      notificationEl = @_scoreContainerEl.find('h1')
      @_destroyNotification(notificationEl)
    ), 3000


  # _destroyNotification
  #
  # Gets a target and removes it, specifically used for
  # the notification.
  _destroyNotification: (target) =>
    target.remove()

  
  # _renderScoreTemplate
  #
  # Renders the score template for individual users using jqMustache
  _renderScoreTemplate: =>
    fail = (response) -> console.error 'failed to render template'

    @jqMustache.load("templates/_userScore.html")
      .done( =>
        @_renderScoreList()
      )
      .fail(fail)


  # _showScoreList 
  #
  # Creates a list of data on the index page with pagination for users.
  _renderScoreList: () =>
    console.log @_scoreData
    @_scoreContainerEl.mustache("userScore", @_scoreData)
     





Scorpio.App.ScoreList = ScoreList
