/* When the user clicks on the button, 
toggle between hiding and showing the dropdown content */
function dropdownMenu() {
  $("#myDropdown").toggleClass("hidden");
}

$(document).ready(function(){
  $('.navbar').on('click', '.dropbtn', function(){
    $(this).siblings('.dropdown-content').toggleClass('hidden');
  })
});