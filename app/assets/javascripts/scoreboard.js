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

PrivatePub.subscribe('/scoreboard', function(){
  var order = $('button.scoreboard-order.btn-primary').data('order');
  $('.scoreboard-content').load('/participants/scoreboard_partial?sort_order=' + order);
});
