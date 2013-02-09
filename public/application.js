$(function($) {

  Notifications.setup();

  // serverNotificationTime is set from the server via index.erb
  var countdown = secondsUntilTime(serverNotificationTime);
  displayTimer(countdown);

  // If already running
  if (serverNotificationTime && serverNotificationTime > new Date().getTime()) {
    var timer = setInterval(tick, 1000);
    $("#toggle").val("Stop");
  }

  $("#form").submit(function() {
    if ($("#toggle").val() == "Start") {
      $("#notificationTime").val(
        new Date().getTime() + $("#minutes").val() * 60 * 1000
      );
      $("#toggle").val("Stop");
    } else {
      clearInterval(timer);
      $.post("/", { notificationTime: null });
      $("#notificationTime").val(0);
      $("#toggle").val("Start");
    }
  });

  //////////////////////////////////////////////////////////////////////////////

  function tick() {
    if (countdown <= 0) {
      clearInterval(timer);
      $("#toggle").val("Start");
      return;
    }
    displayTimer(--countdown);
    if (countdown == 0) Notifications.show("Pomodoro", "Pomodoro complete!");
  }

  function secondsUntilTime(notificationTime) {
    var now = new Date().getTime();
    var defaultTime = now + 25*60*1000;
    var then = notificationTime || defaultTime;
    var seconds = parseInt((then - now) / 1000);
    return seconds > 0 ? seconds : 0;
  }

  function displayTimer(seconds) {
    var m = parseInt(seconds / 60);
    var s = parseInt(seconds - m * 60);
    if (s.toString().length == 1) s = "0" + s;
    $("#countdown").html(m + ":" + s);
  }

});
