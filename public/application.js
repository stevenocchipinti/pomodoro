$(function($) {

  setupNotifications();

  // notificationTime is set from the server (via index.erb)
  var countdown = secondsUntilNotification(notificationTime);
  displayTimer(countdown);
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

  function showNotification() {
    if (window.webkitNotifications.checkPermission() == 0) {
      var popup = window.webkitNotifications.createNotification(
        icon, 'Pomodoro', 'Pomodoro complete - take a break!'
      );
      popup.show();
    }
    snd.play();
  }

  function tick() {
    displayTimer(--countdown);
    if (countdown == 0) {
      showNotification();
      clearInterval(timer);
    }
  }

  function secondsUntilNotification(notificationTime) {
    var now = new Date().getTime();
    var defaultTime = now + 25*60*1000;
    var then = notificationTime || defaultTime;
    return parseInt((then - now) / 1000);
  }

  function displayTimer(seconds) {
    var m = parseInt(seconds / 60);
    var s = parseInt(seconds - m * 60);
    if (s.toString().length == 1) s = "0" + s;
    $("#countdown").html(m + ":" + s);
  }

});
