$(function($) {

  var icon = 'icon.jpg';
  var snd = new Audio("notification.wav");
  var countdown = parseInt($('#countdown').html());
  var timer = setInterval(tick, 1000);

  // Check for desktop notification permissions
  if (window.webkitNotifications.checkPermission() !== 0)
    $("#permission-request").show();

  $("a#permission-request").click(function requestPermission() {
    window.webkitNotifications.requestPermission();
    $("#permission-request").hide();
  });

  function showPopup() {
    if (window.webkitNotifications.checkPermission() == 0) {
      var popup = window.webkitNotifications.createNotification(
        icon, 'Pomodoro', 'Pomodoro complete - take a break!'
      );
      popup.show();
    }
    snd.play();
  }

  function tick() {
    $("#countdown").html(--countdown);
    if (countdown == 0) {
      showPopup();
      clearInterval(timer);
    }
  }

});
