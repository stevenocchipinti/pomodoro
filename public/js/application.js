$(function($) {

  // The following variables are set from the server via index.erb:
  //   Pomodoro.sessionName
  //   Pomodoro.serverNotificationTime

  // Setup Pusher for start/stop via WebSockets
  var pusher = new Pusher(Pomodoro.pusherKey);
  var channel = pusher.subscribe(Pomodoro.sessionName);
  channel.bind('start', function(data) {
    Pomodoro.timer.set(data.notificationTime);
    Pomodoro.timer.start(function() {
      Pomodoro.notifications.show("Pomodoro", "Pomodoro complete!");
    });
  });
  channel.bind('stop', function(data) {
    Pomodoro.timer.stop();
  });

  // WebKit popup notifications and HTML5 audio playback
  Pomodoro.notifications.setup();

  // Automatically start the timer if it is already running
  Pomodoro.timer.set(Pomodoro.serverNotificationTime);
  if (Pomodoro.serverNotificationTime &&
      Pomodoro.serverNotificationTime > new Date().getTime()) {
    Pomodoro.timer.start();
  }

  // Make the button notify the server of a start or stop event
  $("#toggle").click(function() {
    if ($("#toggle").text() == "Start") {
      var notificationTime = new Date().getTime() + $("#minutes").val() * 60 * 1000;
    } else {
      var notificationTime = null;
    }
    $.post("/", {
      sessionName: Pomodoro.sessionName,
      notificationTime: notificationTime
    });
  });

});
