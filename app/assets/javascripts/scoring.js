$(document).ready(function(){
  $('.scoring').on('click', 'button.increment', function(){
    $(this).siblings('button.increment').prop('disabled', false);
    var field_name = $(this).data('field');
    var field = $('input[type=number]#' + field_name);
    if(field){
      var value = parseInt(field.val());
      var type = $(this).data('type');
      if(type === 'minus') value--;
      if(type === 'plus') value++;
      field.val(value);
      var min = field.attr('min');
      var max = field.attr('max');
      if(min && value === parseInt(min)) $(this).prop('disabled', true);
      if(max && value === parseInt(max)) $(this).prop('disabled', true);
    }
  });
});
