$(document).ready(function(){
  $('.scoreboard-sorting').on('click', 'button.scoreboard-order', function(){
    $('img.scoreboard-sort-loading').removeClass('hidden');
    $(this).removeClass('btn-secondary').addClass('btn-primary');
    $(this).siblings('button').removeClass('btn-primary').addClass('btn-secondary');
    var order = $(this).data('order');
    $('.scoreboard-content').load('/participants/scoreboard?sort_order=' + order, function(){
      $('img.scoreboard-sort-loading').addClass('hidden');
    });
  });

});

PrivatePub.subscribe('/scoreboard', function(){
  var order = $('button.scoreboard-order.btn-primary').data('order');
  $('.scoreboard-content').load('/participants/scoreboard?sort_order=' + order);
});
