$(function($) {

  Notifications.setup();

  // serverNotificationTime is set from the server via index.erb
  var timer = null;
  var countdown = secondsUntilTime(serverNotificationTime);
  displayTimer(countdown);

  // If already running
  if (serverNotificationTime && serverNotificationTime > new Date().getTime()) {
    startTimer();
  }

  $("#toggle").click(function() {
    var notificationTime = null;
    if ($("#toggle").text() == "Start") {
      notificationTime = new Date().getTime() + $("#minutes").val() * 60 * 1000
      countdown = secondsUntilTime(notificationTime);
      startTimer();
    } else {
      countdown = secondsUntilTime(notificationTime);
      stopTimer();
    }
    $.post("/", { notificationTime: notificationTime });
  });

  //////////////////////////////////////////////////////////////////////////////

  function startTimer() {
    displayTimer();
    timer = setInterval(tick, 1000);
    $("#toggle").text("Stop");
  }

  function stopTimer() {
    clearInterval(timer);
    displayTimer();
    $("#toggle").text("Start");
  }

  function tick() {
    if (countdown <= 0) {
      stopTimer();
      return;
    }
    displayTimer(--countdown);
    if (countdown == 0) Notifications.show("Pomodoro", "Pomodoro complete!");
  }

  function displayTimer(seconds) {
    if (!seconds) seconds = countdown;
    var m = parseInt(seconds / 60);
    var s = parseInt(seconds - m * 60);
    if (s.toString().length == 1) s = "0" + s;
    $("#countdown").html(m + ":" + s);
  }

  function secondsUntilTime(notificationTime) {
    var now = new Date().getTime();
    var defaultTime = now + $("#minutes").val() * 60 * 1000;
    var then = notificationTime || defaultTime;
    var seconds = parseInt((then - now) / 1000);
    var defaultSeconds = parseInt((defaultTime - now) / 1000);
    return seconds > 0 ? seconds : defaultSeconds;
  }

});
