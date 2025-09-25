App.participants = App.cable.subscriptions.create('ParticipantsChannel', {
  received(data) {
    const participant = data.participant;
    if (data.event == 'add') {
      const newRow = $('table#template tr').first().clone();
      newRow.attr('data-participant-id', participant.id);
      newRow.find('td.participant')
          .text(participant.display_name)
          .attr('data-text', participant.number);
      newRow.find('.maneuver-participant a, .onboard-judging a').attr('href', (_, value) => {
        value.replace(/participant=\d+/, `participant=${participant.number}`);
      });
      $('table.scoreboard').append(newRow);
    } else if (data.event == 'update') {
      $(`tr[data-participant-id=${participant.id}] td.participant`)
          .text(participant.display_name)
          .attr('data-text', participant.number);
    } else if (data.event == 'remove') {
      $(`tr[data-participant-id=${participant.id}]`).remove();
    }
    $('table.scoreboard').trigger('update');
  },
});
