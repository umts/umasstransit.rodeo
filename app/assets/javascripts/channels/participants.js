App.participants = App.cable.subscriptions.create("ParticipantsChannel", {
  received(data) {
    const participant = data.participant;
    switch (data.event) {
      case 'add':
        var new_row = $('table#template tr').first().clone();
        new_row.attr('data-participant-id', participant.id);
        new_row.find('td.participant')
          .text(participant.display_name)
          .attr('data-text', participant.number);
        new_row.find('.maneuver-participant a, .onboard-judging a').attr('href', (_, value) => {
          value.replace(/participant=\d+/, `participant=${participant.number}`);
        });
        $('table.scoreboard').append(new_row);
        break;

      case 'update':
        var cell = $(`tr[data-participant-id=${participant.id}] td.participant`);
        cell.text(participant.display_name).attr('data-text', participant.number);
        break;

      case 'remove':
        var row = $(`tr[data-participant-id=${participant.id}]`);
        row.remove();
        break;
    }
    $('table.scoreboard').trigger('update');
  }
});
