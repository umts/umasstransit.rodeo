App.participants = App.cable.subscriptions.create "ParticipantsChannel",
  received: (data) ->
    participant = data.participant
    switch data.event
      when 'add'
        new_row = $('table#template tr').first().clone()
        new_row.attr('data-participant-id', participant.id)
        new_row.find('td.participant')
          .text(participant.display_name)
          .attr('data-text', participant.number)
        new_row.find('.maneuver-participant a, .onboard-judging a')
          .attr('href', (_, value)->
            value.replace(/participant=\d+/,
                          "participant=#{participant.number}")
        )
        $('table.scoreboard').append(new_row)

      when 'update'
        cell = $("tr[data-participant-id=#{participant.id}] td.participant")
        cell
          .text(participant.display_name)
          .attr('data-text', participant.number)

      when 'remove'
        row = $("tr[data-participant-id=#{participant.id}]")
        row.remove()

    $('table.scoreboard').trigger('update')
