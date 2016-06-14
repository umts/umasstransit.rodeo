function checkPasswordMatch() {
    var password = $("#user_password").val();
    var confirmPassword = $("#user_password_confirmation").val();
    var noMatch = "Passwords do not match!".fontcolor('red');
    var yesMatch = "Passwords match.".fontcolor('green');

    if (password != confirmPassword){
      $("#divCheckPasswordMatch").html(noMatch);
    }
    else{
      $("#divCheckPasswordMatch").html(yesMatch);
      $("#btnSignUp").prop('disabled', false);
    }
    var minLength = $('#user_password').attr('min');
    if (password.length < minLength){
      $("#divCheckPasswordMatch").html("Password is too short".fontcolor('red'));
      $("#btnSignUp").prop('disabled', true);
    }
};
$(document).ready(function(){
   $("#txtConfirmPassword").keyup(checkPasswordMatch);
});
