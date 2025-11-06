App.onboard_judgings = App.cable.subscriptions.create('OnboardJudgingsChannel', {
  received(data) {
    const participant = data.participant_id;
    const score = data.score;
    const cell = $(`tr[data-participant-id=${participant}] td.onboard-judging`);
    cell.text(score).attr('data-text', score).attr('data-score', score);
    $('table.scoreboard').trigger('recalculate');
    flashCell(cell);
  },
});
