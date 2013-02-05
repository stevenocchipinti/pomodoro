$(function($) {

  var icon = 'public/icon.jpg';
  var snd = new Audio("public/notification.wav");
  var countdown = parseInt($('#countdown').html());
  var timer = setInterval(tick, 1000);

  // Check for desktop notification permissions
  if (window.webkitNotifications.checkPermission() !== 0)
    $("#permission-request").show();

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
