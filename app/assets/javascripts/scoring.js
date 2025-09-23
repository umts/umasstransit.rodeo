$(function() {
  $('#score_form').areYouSure();

  $('.scoring').on('click', 'button.increment', function() {
    const field = $('input[type=number]#' + $(this).data('field'));
    if (field) {
      let value = parseInt(field.val());
      const type = $(this).data('type');
      if (type === 'minus') value--;
      if (type === 'plus') value++;
      field.val(value).trigger('change');
    }
  });

  $('.scoring').on('change', 'input[type=number]', function() {
    const buttons = $('button.increment[data-field=' + $(this).attr('id') + ']');
    buttons.prop('disabled', false);
    const value = parseInt($(this).val());
    const min = parseInt($(this).attr('min'));
    const max = parseInt($(this).attr('max'));
    if (value <= min) buttons.filter('[data-type=minus]').prop('disabled', true);
    if (value >= max) buttons.filter('[data-type=plus]').prop('disabled', true);
  });
});
