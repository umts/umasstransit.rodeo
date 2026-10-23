import consumer from "./consumer";
import updateScoreboardCell from "../update_scoreboard_cell";

function scoreLink(url, score) {
  const link = document.createElement("a");
  link.href = url;
  link.textContent = score;
  return link;
}

const scoreboard = document.querySelector("table.scoreboard");

if (consumer && scoreboard) {
  consumer.subscriptions.create("ManeuverParticipantsChannel", {
    received(data) {
      const participant = data.participant_id;
      const maneuver = data.maneuver_id;
      const cell = document.querySelector(
        `tr[data-participant-id="${participant}"] td[data-maneuver-id="${maneuver}"]`,
      );
      const score = data.score;
      const canEditScores = cell.closest("table.scoreboard").dataset.canEditScores === "true";
      const content = canEditScores ? scoreLink(data.url, score) : null;

      updateScoreboardCell(cell, score, content);
    },
  });
}
