App.quiz_scores = App.cable.subscriptions.create "QuizScoresChannel",
  received: (data) ->
    $("tr[data-participant-id=#{data.participant_id}] td.quiz-score").text(data.score)
