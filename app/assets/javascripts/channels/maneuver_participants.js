App.manuever_participants = App.cable.subscriptions.create("ManeuverParticipantsChannel", {
  received(data) {
    const participant = data.participant_id;
    const maneuver = data.maneuver_id;
    const score = data.score;

    const cell = $(`tr[data-participant-id=${participant}] td[data-maneuver-id=${maneuver}]`);
    const a = cell.find('a');
    if (a.length) {
      a.text(score);
    } else {
      cell.text(score);
    }
    cell.attr('data-text', score).attr('data-score', score);
    $("table.scoreboard").trigger("recalculate");
    flashCell(cell);
  }
});
