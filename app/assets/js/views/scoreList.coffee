views = Scorpio.views

class ScoreList
  constructor: ->
    @win = $(window)
    @document = $(document)
    @obody = $('body')

    ## Get Elements
    @_scoreContainerEl = $('.score-container')

    @init()



  # init
  #
  # Initializes the entire module
  init: =>
    domReady = =>
      @_initializeBindings()

    $(domReady)

  # _initializeEvents
  #
  # Initializes our listeners to show notifications 
  # and display the score list.
  _initializeBindings: =>
    ## On a new event we need to update the view with a new score.
    @document.on 'score-update', (event, opt_data) =>
      data = opt_data

      @_updateTotalScores(data._scoreData)
      @_showNotification(data)

      
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
                                        

  # _updateTotalScores
  #
  # Will update our total scores for the list toget data from
  # data {Array} an array of scores
  _updateTotalScores: (data) ->
    Scorpio.data._scoreData = [] || data


Scorpio.App.ScoreList = ScoreList
