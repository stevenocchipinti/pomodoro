$(function($) {


  var pusher = new Pusher('3521c8facdca5d505db3');
  var channel = pusher.subscribe('events');

  // FIXME
  // channel.bind('start', start);
  // channel.bind('stop', stop);

  channel.bind('start', function(data) {
    Timer.set(data.notificationTime);
    Timer.start();
  });
  channel.bind('stop', function(data) {
    Timer.stop();
  });


  Notifications.setup();

  // serverNotificationTime is set from the server via index.erb
  Timer.set(serverNotificationTime);
  Timer.updateDisplay();

  // If already running
  if (serverNotificationTime && serverNotificationTime > new Date().getTime()) {
    Timer.start();
  }

  $("#toggle").click(function() {
    if ($("#toggle").text() == "Start") {
      var notificationTime = new Date().getTime() + $("#minutes").val() * 60 * 1000;
    } else {
      var notificationTime = null;
    }
    $.post("/", { notificationTime: notificationTime });
  });


  // FIXME
  // POMODORO OBJECT??!

  function start() {
    var notificationTime = new Date().getTime() + $("#minutes").val() * 60 * 1000;
    Timer.set(notificationTime);
    Timer.start();
  }

  function stop() {
    Timer.stop();
  }

});
