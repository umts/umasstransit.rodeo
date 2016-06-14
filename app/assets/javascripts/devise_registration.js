function checkPasswordMatch() {
    var password = $("#txtNewPassword").val();
    var confirmPassword = $("#txtConfirmPassword").val();
    var noMatch = "Passwords do not match!".fontcolor('red');
    var yesMatch = "Passwords match.".fontcolor('green');

    if (password != confirmPassword){
      $("#divCheckPasswordMatch").html(noMatch);
    }
    else{
      $("#divCheckPasswordMatch").html(yesMatch);
    }
    var minLength = $('#txtNewPassword').attr('min');
    if (password.length < minLength){
      $("#divCheckPasswordMatch").html("Password is too short".fontcolor('red'));
      $("#btnSignUp").prop('disabled', true);
    }
};
$(document).ready(function () {
   $("#txtConfirmPassword").keyup(checkPasswordMatch);
});
