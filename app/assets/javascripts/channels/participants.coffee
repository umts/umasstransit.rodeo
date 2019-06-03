App.participants = App.cable.subscriptions.create "ParticipantsChannel",
  connected: ->
  disconnected: ->
  received: (data) ->
    switch data.event
      when 'add'
        console.log({'add': data})
      when 'update'
        cell = $("tr[data-participant-id=#{data.participant.id}] td.participant")
        cell.text(data.participant.display_name).attr('data-text', data.participant.number)
      when 'remove'
        row = $("tr[data-participant-id=#{data.participant.id}]")
        row.remove()
    $('table.scoreboard').trigger('update')
