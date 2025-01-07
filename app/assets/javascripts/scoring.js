$(function(){
  $('#score_form').areYouSure();

  $('.scoring').on('click', 'button.increment', function(){
    var field = $("input[type=number]#" + $(this).data('field'));
    if(field){
      var value = parseInt(field.val());
      var type = $(this).data('type');
      if(type === 'minus') value--;
      if(type === 'plus') value++;
      field.val(value).trigger('change');
    }
  });

  $('.scoring').on('change', 'input[type=number]', function(){
    var buttons = $('button.increment[data-field=' + $(this).attr('id') + ']');
    buttons.prop('disabled', false);
    var value = parseInt($(this).val());
    var min = parseInt($(this).attr('min'));
    var max = parseInt($(this).attr('max'));
    if(value <= min) buttons.filter('[data-type=minus]').prop('disabled', true);
    if(value >= max) buttons.filter('[data-type=plus]').prop('disabled', true);
  });
});
