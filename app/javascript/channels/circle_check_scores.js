import consumer from "./consumer";
import updateScoreboardCell from "../update_scoreboard_cell";

consumer.subscriptions.create("CircleCheckScoresChannel", {
  received(data) {
    const participant = data.participant_id;
    const cell = document.querySelector(
      `tr[data-participant-id="${participant}"] td.circle-check-score`,
    );
    const score = data.score.toFixed(1);
    updateScoreboardCell(cell, score);
  },
});
