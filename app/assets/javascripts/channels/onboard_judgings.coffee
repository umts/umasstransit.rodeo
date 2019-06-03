App.onboard_judgings = App.cable.subscriptions.create "OnboardJudgingsChannel",
  received: (data) ->
    cell = $("tr[data-participant-id=#{data.participant_id}] td.onboard-judging")
    cell.text(data.score).attr('data-text', data.score).attr('data-score', data.score)
    $("table.scoreboard").trigger("recalculate")
