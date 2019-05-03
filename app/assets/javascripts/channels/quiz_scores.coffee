App.quiz_scores = App.cable.subscriptions.create "QuizScoresChannel",
  connected: ->
  disconnected: ->
  received: (data) ->
    console.log(data)
