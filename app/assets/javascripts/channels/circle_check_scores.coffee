App.circle_check_scores =
  App.cable.subscriptions.create "CircleCheckScoresChannel",
    received: (data) ->
      participant = data.participant_id
      score = data.score
      cell = $("tr[data-participant-id=#{participant}] td.circle-check-score")
      cell.text(score).attr('data-text', score).attr('data-score', score).addClass('last-updated')
      $("table.scoreboard").trigger("recalculate")
      setTimeout ->
        cell.removeClass('last-updated')
      , 5000
