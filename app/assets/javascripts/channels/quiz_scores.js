App.quiz_scores = App.cable.subscriptions.create('QuizScoresChannel', {
  received(data) {
    const participant = data.participant_id;
    const score = data.score;
    const cell = $(`tr[data-participant-id=${participant}] td.quiz-score`);
    cell.text(score.toFixed(1)).attr('data-text', score.toFixed(1)).attr('data-score', score);
    $('table.scoreboard').trigger('recalculate');
    flashCell(cell);
  },
});
