function checkPasswordMatch() {
    var password = $("#txtNewPassword").val();
    var confirmPassword = $("#txtConfirmPassword").val();

    if (password != confirmPassword){
      $("#divCheckPasswordMatch").html("Passwords do not match!");
      document.getElementById("btnSignUp").disabled = true;
    }
    else{
      $("#divCheckPasswordMatch").html("Passwords match.");
      document.getElementById("btnSignUp").disabled = false;
    }
};
$(document).ready(function () {
   $("#txtConfirmPassword").keyup(checkPasswordMatch);
});
