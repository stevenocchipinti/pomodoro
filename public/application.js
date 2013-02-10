$(function($) {

  Notifications.setup();

  // serverNotificationTime is set from the server via index.erb
  Timer.set(serverNotificationTime);
  Timer.updateDisplay();

  // If already running
  if (serverNotificationTime && serverNotificationTime > new Date().getTime()) {
    Timer.start();
  }

  $("#toggle").click(function() {
    var notificationTime = null;
    if ($("#toggle").text() == "Start") {
      notificationTime = new Date().getTime() + $("#minutes").val() * 60 * 1000
      Timer.set(notificationTime);
      Timer.start();
    } else {
      Timer.stop();
    }
    $.post("/", { notificationTime: notificationTime });
  });

});
