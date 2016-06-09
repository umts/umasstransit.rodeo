function checkPasswordMatch() {
    var password = $("#txtNewPassword").val();
    var confirmPassword = $("#txtConfirmPassword").val();
    var noMatch = "Passwords do not match!".fontcolor('red');
    var yesMatch = "Passwords match.".fontcolor('green');

    if (password != confirmPassword){
      $("#divCheckPasswordMatch").html(noMatch);
      document.getElementById("btnSignUp").disabled = true;
    }
    else{
      $("#divCheckPasswordMatch").html(yesMatch);
      document.getElementById("btnSignUp").disabled = false;
    }
};
$(document).ready(function () {
   $("#txtConfirmPassword").keyup(checkPasswordMatch);
});
