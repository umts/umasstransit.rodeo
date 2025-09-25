$(function() {
  if ($('.participants .uniqueness-warning').is(':visible')) {
    $('.uniqueness-warning').hide();
  }

  $('.participants').on('change', 'input[type=number]', function(e) {
    const existingNumbers = $('.participants input[type=number]').not($(e.target)).map(function(_, other) {
      return parseInt($(other).val());
    });
    const currentNumber = parseInt($(e.target).val());
    if (existingNumbers.index(currentNumber) !== -1) {
      $('.uniqueness-warning').show();
    } else $('.uniqueness-warning').hide();
  });
});
