App.quiz_scores = App.cable.subscriptions.create "QuizScoresChannel",
  received: (data) ->
    participant = data.participant_id
    score = data.score
    cell = $("tr[data-participant-id=#{participant}] td.quiz-score")
    cell.text(data.score).attr('data-text', score).attr('data-score', score)
    $("table.scoreboard").trigger("recalculate")
    flashCell(cell)
