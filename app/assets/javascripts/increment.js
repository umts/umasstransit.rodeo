$(() => {
  $('.increment').on('click', 'button', function () {
    const field = $(this).parent().siblings(':input');
    if (field) {
      var value = parseInt(field.val());
      const action = $(this).data('action');
      if (action === 'decrement') value--;
      if (action === 'increment') value++;
      field.val(value).trigger('change');
    }
  });

  $('.increment').on('change', 'input[type=number]', function () {
    const buttons = $(this).siblings().children(':button');
    buttons.prop('disabled', false);
    const value = parseInt($(this).val());
    const min = parseInt($(this).attr('min'));
    const max = parseInt($(this).attr('max'));
    if(value <= min) buttons.filter('[data-action=decrement]').prop('disabled', true);
    if(value >= max) buttons.filter('[data-action=increment]').prop('disabled', true);
  });

  $('.increment input').trigger('change');
});
