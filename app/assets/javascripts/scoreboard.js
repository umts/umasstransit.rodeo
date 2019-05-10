$(document).ready(function(){
  $('.scoreboard-sorting').on('click', 'button.scoreboard-order', function(){
    $('img.scoreboard-sort-loading').removeClass('d-none');
    $(this).removeClass('btn-secondary').addClass('btn-primary');
    $(this).siblings('button').removeClass('btn-primary').addClass('btn-secondary');
    var order = $(this).data('order');
    $('.scoreboard-content').load('/participants/scoreboard_partial?sort_order=' + order, function(){
      $('img.scoreboard-sort-loading').addClass('d-none');
    });
  });

  $('.scoreboard').on('click', 'button.fullscreen', function(){
    var scoreboard = $('.scoreboard-content').get(0);
    if (scoreboard.requestFullscreen) {
      scoreboard.requestFullscreen();
    }
  });
});

function updateManeuverTotal(participant_id){
  $(`tr[data-participant-id=${participant_id}] td.maneuver-score`).text(function(){
    var score = 0;
    $(`tr[data-participant-id=${participant_id}] td.maneuver-participant`).each(function(){
      var a = $(this).find('a')
      if (a.length) {
        score += Number(a.text()) || 0;
      } else {
        score += Number($(this).text()) || 0;
      }
    });
    return score;
  });
}

function updateTotal(participant_id){
  $(`tr[data-participant-id=${participant_id}] td.total-score`).text(function(){
    var maneuverScore = $(`tr[data-participant-id=${participant_id}] td.maneuver-score`).text();
    var onboardJudging = $(`tr[data-participant-id=${participant_id}] td.onboard-judging`).text();
    var circleCheckScore = $(`tr[data-participant-id=${participant_id}] td.circle-check-score`).text();
    var quizScore = $(`tr[data-participant-id=${participant_id}] td.quiz-score`).text();
    var score = (Number(maneuverScore) || 0) +
                (Number(onboardJudging) || 0) +
                (Number(circleCheckScore) || 0) +
                (Number(quizScore) || 0);
    return score.toFixed(1)
  });
}
