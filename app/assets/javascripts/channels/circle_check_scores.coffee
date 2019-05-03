App.circle_check_scores = App.cable.subscriptions.create "CircleCheckScoresChannel",
  connected: ->
  disconnected: ->
  received: (data) ->
    console.log(data)
