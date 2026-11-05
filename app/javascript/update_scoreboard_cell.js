export default function updateScoreboardCell(cell, score, content = null) {
  const scoreboard = document.querySelector("table.scoreboard");

  cell.replaceChildren(content || String(score));
  cell.dataset.text = score;
  cell.dataset.score = score;

  scoreboard.dispatchEvent(new Event("recalculate"));
  scoreboard.dispatchEvent(new Event("update", [true]));

  cell.classList.add("last-updated");
  setTimeout(() => {
    cell.classList.remove("last-updated");
  }, 5000);
}
