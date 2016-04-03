$(document).ready(function(){
  $('.faye-test').on('click', 'button.test', function(){
    $.post('/faye_test').fail(function(data){
      $('.failure').removeClass('hidden');
      $('.failure-reason').text(data.responseText);
    });
  });

  PrivatePub.subscribe('/test', function(){
    $('.success').removeClass('hidden');
  });
});
