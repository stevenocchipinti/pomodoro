$(function($) {

  // Setup Pusher for start/stop via WebSockets
  var pusher = new Pusher('3521c8facdca5d505db3');
  var channel = pusher.subscribe('events');
  channel.bind('start', function(data) {
    Timer.set(data.notificationTime);
    Timer.start();
  });
  channel.bind('stop', function(data) {
    Timer.stop();
  });

  // WebKit popup notifications and HTML5 audio playback
  Notifications.setup();

  // Automatically start the timer if it is already running
  // serverNotificationTime is set from the server via index.erb
  Timer.set(serverNotificationTime);
  if (serverNotificationTime && serverNotificationTime > new Date().getTime()) {
    Timer.start();
  }

  // Make the button notify the server of a start or stop event
  $("#toggle").click(function() {
    if ($("#toggle").text() == "Start") {
      var notificationTime = new Date().getTime() + $("#minutes").val() * 60 * 1000;
    } else {
      var notificationTime = null;
    }
    $.post("/", { notificationTime: notificationTime });
  });

});
