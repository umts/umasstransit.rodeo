App.circle_check_scores = App.cable.subscriptions.create "CircleCheckScoresChannel",
  received: (data) ->
    cell = $("tr[data-participant-id=#{data.participant_id}] td.circle-check-score")
    cell.text(data.score).attr('data-text', data.score).attr('data-score', data.score)
    $("table.scoreboard").trigger("recalculate")
