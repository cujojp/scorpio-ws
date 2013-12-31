#= require "models/scorpioSockets"
#= require "classes/scorpioScoreController"
#= require "views/scoreList"

(($, Scorpio) ->
  Scorpio.sockets = new Scorpio.App.ScorpioSockets()
  Scorpio.scoreList = new Scorpio.App.ScoreList()
  Scorpio.scoreController = new Scorpio.App.ScorpioScoreController()
) jQuery, Scorpio

