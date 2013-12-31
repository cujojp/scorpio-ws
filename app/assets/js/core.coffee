#= require "models/scorpioSockets"
#= require "views/scoreList"

(($, Scorpio) ->
  Scorpio.sockets = new Scorpio.App.ScorpioSockets()
  Scorpio.scoreList = new Scorpio.App.ScoreList()
) jQuery, Scorpio

