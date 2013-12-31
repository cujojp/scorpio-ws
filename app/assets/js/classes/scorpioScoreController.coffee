# fileoverview
# ScorpioScoreController

class ScorpioScoreController

  constructor: ->
    @window = $(window)
    @document = $(document)

  # getTotalScores
  #
  # Will update our total scores for the list toget data from
  # data {Array} an array of scores
  getTotalScores: (hollaback) =>
    dataQuery = "/js/data.js"
    
    $.ajax
      url: dataQuery
      type: 'get'
      dataType: 'json'
      error: (jqXHR, textStatus, errorThrown) =>
        if errorThrown = 'abort' then return else console.warn errorThrown
      success: (data, textStatus, jqXHR) =>
        if typeof hollaback is 'function' then hollaback(data)

  getUserDetails: (user) =>
    if !user then console.warn 'No user found'

    # get the current data
    currData = Scorpio.data._scoreData
    userData = null

    # check for our user in the data field
    for obj, i in currData
      userName = obj._user

      # once we found the user name then break
      if user.toLowerCase() == userName.toLowerCase()
        userData = obj
        break
      else if (i+1) == currData.length
        console.warn "No User of #{user} was found"
        break

    return userData



Scorpio.App.ScorpioScoreController = ScorpioScoreController
