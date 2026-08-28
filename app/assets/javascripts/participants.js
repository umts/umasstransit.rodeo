$(function () {
  if ($(".participants .uniqueness-warning").is(":visible")) {
    $(".uniqueness-warning").hide();
  }

  $(".participants").on("change", "input[type=number]", function (e) {
    const existingNumbers = $(".participants input[type=number]")
      .not($(e.target))
      .map(function (_, other) {
        return Math.trunc(Number($(other).val()));
      });
    const currentNumber = Math.trunc(Number($(e.target).val()));
    if (existingNumbers.index(currentNumber) === -1) {
      $(".uniqueness-warning").hide();
    } else {
      $(".uniqueness-warning").show();
    }
  });
});
