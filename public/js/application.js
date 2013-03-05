$(function($) {

  // Pomodoro.session is set from the server via index.erb

  // Setup Pusher for start/stop via WebSockets
  var pusher = new Pusher(Pomodoro.pusherKey);
  var channel = pusher.subscribe(Pomodoro.session.name);
  channel.bind('start', function(data) {
    // TODO: Remove this duplication
    $("#minutes").val(data.session.duration);
    Pomodoro.session = data.session;
    Pomodoro.timer.set(data.session.notification_time);
    Pomodoro.timer.start(function() {
      Pomodoro.notifications.show("Pomodoro", "Pomodoro complete!");
    });
  });
  channel.bind('stop', function(data) {
    Pomodoro.timer.stop();
  });

  // WebKit popup notifications and HTML5 audio playback
  Pomodoro.notifications.setup();

  // TODO: Remove this duplication
  // Set the notification on the timer and the minutes configuration
  $("#minutes").val(Pomodoro.session.duration);
  Pomodoro.timer.set(Pomodoro.session.notificationTime);

  // Automatically start the timer if it is already running
  if (Pomodoro.session.notificationTime &&
      Pomodoro.session.notificationTime > new Date().getTime()) {
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
      session: {
        name: Pomodoro.session.name,
        notification_time: notificationTime,
        duration: $("#minutes").val()
      }
    });
  });

});
