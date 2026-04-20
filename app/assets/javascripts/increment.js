$(() => {
  $('.increment').on('click', 'button', (e) => {
    const field = $(e.target).closest(':button').parent().siblings('input');
    if (field) {
      let value = parseInt(field.val());
      const action = $(e.target).closest(':button').data('action');
      if (action === 'decrement') value--;
      if (action === 'increment') value++;
      field.val(value).trigger('change');
    }
  });

  $('.increment').on('change', 'input[type=number]', (e) => {
    const buttons = $(e.target).siblings().children(':button');
    buttons.prop('disabled', false);
    const value = parseInt($(e.target).val());
    const min = parseInt($(e.target).attr('min'));
    const max = parseInt($(e.target).attr('max'));
    if (value <= min) buttons.filter('[data-action=decrement]').prop('disabled', true);
    if (value >= max) buttons.filter('[data-action=increment]').prop('disabled', true);
  });

  $('.increment input').trigger('change');
});
