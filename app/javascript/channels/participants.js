import consumer from "./consumer";

function participantRow(scoreboard, participantId) {
  return scoreboard.querySelector(`tr[data-participant-id="${participantId}"]`);
}

function updateParticipantLink(link, participantNumber) {
  const url = new URL(link.href);
  url.searchParams.set("participant", participantNumber);
  link.href = url;
}

function addParticipant(scoreboard, participant) {
  const row = document.querySelector("table#template tr").cloneNode(true);
  row.dataset.participantId = participant.id;

  const participantCell = row.querySelector("td.participant");
  participantCell.textContent = participant.display_name;
  participantCell.dataset.text = participant.number;

  const scoreLinks = row.querySelectorAll(".maneuver-participant a, .onboard-judging a");
  for (const link of scoreLinks) updateParticipantLink(link, participant.number);

  scoreboard.tBodies[0].append(row);
}

function updateParticipant(scoreboard, participant) {
  const participantCell = participantRow(scoreboard, participant.id).querySelector(
    "td.participant",
  );
  participantCell.textContent = participant.display_name;
  participantCell.dataset.text = participant.number;
}

function removeParticipant(scoreboard, participant) {
  const row = participantRow(scoreboard, participant.id);
  if (row) row.remove();
}

const scoreboard = document.querySelector("table.scoreboard");

if (consumer && scoreboard) {
  consumer.subscriptions.create("ParticipantsChannel", {
    received(data) {
      if (data.event === "add") addParticipant(scoreboard, data.participant);
      if (data.event === "update") updateParticipant(scoreboard, data.participant);
      if (data.event === "remove") removeParticipant(scoreboard, data.participant);

      scoreboard.dispatchEvent(new Event("update"));
    },
  });
}
