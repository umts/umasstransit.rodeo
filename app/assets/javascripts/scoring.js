$(document).ready(function(){
  $('#score_form').areYouSure();

  $('.scoring').on('click', 'button.increment', function(){
    var field_name = $(this).data('field');
    $("[data-field='" + field_name + "']").prop('disabled', false);
    var field = $('input[type=number]#' + field_name);
    if(field){
      var value = parseInt(field.val());
      var type = $(this).data('type');
      if(type === 'minus') value--;
      if(type === 'plus') value++;
      field.val(value).change();
      var min = field.attr('min');
      var max = field.attr('max');
      if(value === parseInt(min)) $(this).prop('disabled', true);
      if(value === parseInt(max)) $(this).prop('disabled', true);
    }
  });
});
