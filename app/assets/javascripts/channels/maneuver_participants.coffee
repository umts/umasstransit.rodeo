App.manuever_participants =
  App.cable.subscriptions.create "ManeuverParticipantsChannel",
    received: (data) ->
      participant = data.participant_id
      maneuver = data.maneuver_id
      score = data.score

      cell = $("tr[data-participant-id=#{participant}]
                td[data-maneuver-id=#{maneuver}]")
      a = cell.find('a')
      if a.length
        a.text(score)
      else
        cell.text(score)
      cell.attr('data-text', score).attr('data-score', score).addClass('last-updated')
      $("table.scoreboard").trigger("recalculate")
      setTimeout ->
        cell.removeClass('last-updated')
      , 5000
