$(function () {
  $("#score_form").areYouSure();

  $(".scoring").on("click", "button.increment", function (e) {
    const button = $(e.target).closest("button");
    const field = $("input[type=number]#" + button.data("field"));
    if (field) {
      let value = Math.trunc(Number(field.val()));
      const type = button.data("type");
      if (type === "minus") value -= 1;
      if (type === "plus") value += 1;
      field.val(value).trigger("change");
    }
  });

  $(".scoring").on("change", "input[type=number]", function (e) {
    const buttons = $("button.increment[data-field=" + $(e.target).attr("id") + "]");
    buttons.prop("disabled", false);
    const value = Math.trunc(Number($(e.target).val()));
    const min = Math.trunc(Number($(e.target).attr("min")));
    const max = Math.trunc(Number($(e.target).attr("max")));
    if (value <= min) buttons.filter("[data-type=minus]").prop("disabled", true);
    if (value >= max) buttons.filter("[data-type=plus]").prop("disabled", true);
  });
});
