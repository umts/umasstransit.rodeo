App.onboard_judgings = App.cable.subscriptions.create "OnboardJudgingsChannel",
  connected: ->
  disconnected: ->
  received: (data) ->
    console.log(data)
