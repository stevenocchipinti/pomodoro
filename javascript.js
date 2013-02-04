$(function($) {

  var icon = 'icon.jpg';
  var snd = new Audio("file.wav");
  var countdown = parseInt($('#countdown').html());
  var timer = 0;

  // Check for desktop notification permissions
  if (window.webkitNotifications.checkPermission() !== 0)
    $("#permission").html(
      "Looks like you haven't enabled desktop notifications, " +
      "<a href='#' onclick='window.webkitNotifications.requestPermission();'>" +
      "click here to enable</a>"
    );

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

  timer = setInterval(tick, 1000);

});
