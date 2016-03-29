$(document).ready(function(){
  if($('.participants .uniqueness-warning').is(':visible'))
    $('.uniqueness-warning').hide();

  $('.participants').on('change', 'input[type=number]', function(){
    var existingNumbers = $('.participants input[type=number]').not($(this)).map(function(){
      return parseInt($(this).val());
    });
    existingNumbers = $.unique(existingNumbers);
    currentNumber = parseInt($(this).val());
    if(existingNumbers.index(currentNumber) !== -1)
      $('.uniqueness-warning').show();
    else $('.uniqueness-warning').hide();
  });
});
