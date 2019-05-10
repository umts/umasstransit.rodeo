App.onboard_judgings = App.cable.subscriptions.create "OnboardJudgingsChannel",
  received: (data) ->
    $("tr[data-participant-id=#{data.participant_id}] td.onboard-judging").text(data.score)
    updateTotal(data.participant_id)
