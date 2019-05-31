App.circle_check_scores = App.cable.subscriptions.create "CircleCheckScoresChannel",
  received: (data) ->
    $("tr[data-participant-id=#{data.participant_id}] td.circle-check-score").text(data.score)
