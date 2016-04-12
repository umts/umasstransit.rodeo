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
  $(function() {
    $('#score_form').areYouSure();
  })
  $(".score_fields :button").click(function() {
    setTimeout(function() {
      $(".score_fields :input[type=number]").each(function(){
        if ($(this).val() != '0') {
          var currentVal = $(this).val();
          $(this).val(currentVal).change();
        } else {
          $('#score_form').removeClass('dirty');
        }
      });
    });
  });
});

/*
    $(".score_fields :button").click(function() {
      $(".score_fields :input[type=number]").each(function(){
        if ($(this).val() != '0') {
          var currentVal = $(this).val();
          $(this).val(currentVal).change();
        } else {
          $('#score_form').removeClass('dirty');
        }
      });
    });
  });
  $('.score_fields :input[type=number]').each(function(){
    if ($(this).val() != '0') {
      $('#score_form').addClass('dirty')
    } else {
      $('#score_form').removeClass('dirty')
    }
  })
*/
