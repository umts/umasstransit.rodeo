App.quiz_scores = App.cable.subscriptions.create "QuizScoresChannel",
  received: (data) ->
    cell = $("tr[data-participant-id=#{data.participant_id}] td.quiz-score")
    cell.text(data.score).attr('data-text', data.score).attr('data-score', data.score)
    $("table.scoreboard").trigger("recalculate")
