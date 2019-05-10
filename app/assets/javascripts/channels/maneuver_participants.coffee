App.manuever_participants = App.cable.subscriptions.create "ManeuverParticipantsChannel",
  received: (data) ->
    cell = $("tr[data-participant-id=#{data.participant_id}] td[data-maneuver-id=#{data.maneuver_id}]")
    a = cell.find('a')
    if a.length
      a.text(data.score)
    else
      cell.text(data.score)
    updateManeuverTotal(data.participant_id)
    updateTotal(data.participant_id)
