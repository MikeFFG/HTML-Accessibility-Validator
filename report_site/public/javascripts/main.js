$(function() {
  /* Constants */
  $tabs = $(".tabs li");

  /* Initialization */
  $(window).on("load", function() {
    $tabs[0].click();
  });

  /* Event Handlers */
  $tabs.on("click", function() {
    $tabs.removeClass("selected");
    $(this).toggleClass("selected");
  });
});
