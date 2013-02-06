$(function($) {

  setupNotifications();
  // notificationTime is set from the server (via index.erb)
  var countdown = secondsUntilNotification(notificationTime);
  $("#countdown").html(countdown);
  var timer = setInterval(tick, 1000);

  var icon = 'icon.jpg';
  var snd = new Audio("notification.wav");

  function setupNotifications() {
    $("a#permission-request").click(function requestPermission() {
      window.webkitNotifications.requestPermission();
      $("#permission-request").hide();
    });
    if (window.webkitNotifications.checkPermission() !== 0) {
      $("#permission-request").show();
    }
  }

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

  function secondsUntilNotification(notificationTime) {
    var now = new Date().getTime();
    var defaultTime = now + 25*60*1000;
    var then = notificationTime || defaultTime;
    return parseInt((then - now) / 1000);
  }

});
