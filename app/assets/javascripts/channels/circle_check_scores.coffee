App.circle_check_scores =
  App.cable.subscriptions.create "CircleCheckScoresChannel",
    received: (data) ->
      participant = data.participant_id
      score = data.score
      cell = $("tr[data-participant-id=#{participant}] td.circle-check-score")
      cell.text(score).attr('data-text', score).attr('data-score', score)
      $("table.scoreboard").trigger("recalculate")
      flashCell(cell)
