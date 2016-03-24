$(document).ready(function(){
  $('#scoring').on('change', '#bus_number', function(){
    var bus_number = $(this).val();
    if(bus_number){
      $.get('/buses/' + bus_number + '/participants', function(participants){
        // un-disable the selector
        $('#participant_number').prop('disabled', false);
        // remove existing options
        $('#participant_number option').remove();
        $('#participant_number').append(new Option('Select a participant...', ''));
        _.each(participants, function(participant){
          $('#participant_number').append(new Option(participant.number + " - " + participant.name, participant.number));
        });
        // select the empty option
        $('#participant_number').val('');
      });
    }
    else{
      // disable the selector
      $('#participant_number').prop('disabled', true);
      // remove existing options
      $('#participant_number option').remove();
      // include blank
      $('#participant_number').append(new Option('Select a bus number first...', ''));
    }
  });
})
