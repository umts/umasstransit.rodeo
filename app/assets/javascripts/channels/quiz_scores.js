App.quiz_scores = App.cable.subscriptions.create("QuizScoresChannel", {
  received(data) {
    const participant = data.participant_id;
    const score = data.score;
    const cell = $(`tr[data-participant-id=${participant}] td.quiz-score`);
    cell.text(data.score).attr('data-text', score).attr('data-score', score);
    $("table.scoreboard").trigger("recalculate");
    flashCell(cell);
  }
});
