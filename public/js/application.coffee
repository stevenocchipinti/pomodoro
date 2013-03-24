jQuery ->

  # Pomodoro.session is set from the server via index.erb

  # Setup Pusher for start/stop via WebSockets
  pusher = new Pusher(Pomodoro.pusherKey)
  channel = pusher.subscribe(Pomodoro.session.name)
  channel.bind 'start', (data) ->

    # TODO: Remove this duplication #2
    $("#minutes").val(data.session.duration)
    Pomodoro.session = data.session
    Pomodoro.timer.set data.session.notification_time

    # TODO: Remove this duplication #1
    Pomodoro.timer.start ->
      Pomodoro.notifications.show("Pomodoro", "Pomodoro complete!")

  channel.bind 'stop', (data) ->
    Pomodoro.timer.stop()

  # WebKit popup notifications and HTML5 audio playback
  Pomodoro.notifications.setup()

  # TODO: Remove this duplication #1
  # Set the notification on the timer and the minutes configuration
  $("#minutes").val Pomodoro.session.duration
  Pomodoro.timer.set Pomodoro.session.notificationTime

  # Automatically start the timer if it is already running
  if Pomodoro.timer.is_running()
    # TODO: Remove this duplication #1
    Pomodoro.timer.start ->
      Pomodoro.notifications.show("Pomodoro", "Pomodoro complete!")

  # Make the button notify the server of a start or stop event
  $("#toggle").click ->
    if $("#toggle").text() == "Start"
      notificationTime = new Date().getTime() + $("#minutes").val() * 60 * 1000
    else
      notificationTime = null
    $.post "/",
      session:
        name: Pomodoro.session.name,
        notification_time: notificationTime,
        duration: $("#minutes").val()
