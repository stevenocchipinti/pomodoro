jQuery ->

  # Pomodoro.session is set from the server via index.erb

  loadSession = ->
    $("#minutes").val 25 #Pomodoro.session.duration
    Pomodoro.timer.set null #Pomodoro.session.notificationTime


  # Setup what to do when the timer is complete (popup notification + sound)
  Pomodoro.timer.onComplete = ->
    Pomodoro.notifications.show("Pomodoro", "Pomodoro complete!")


  # # Setup Pusher for start/stop via WebSockets
  # pusher = new Pusher(Pomodoro.pusherKey)
  # channel = pusher.subscribe(Pomodoro.session.name)
  # channel.bind 'start', (data) ->
  #   Pomodoro.session = data.session
  #   loadSession()
  #   Pomodoro.timer.start()
  # channel.bind 'stop', (data) ->
  #   Pomodoro.timer.stop()


  Pomodoro.notifications.setup()
  loadSession()
  # Pomodoro.timer.start() if Pomodoro.timer.is_running()


  # Make the button notify the server of a start or stop event
  $("#toggle").click ->

    if $("#toggle").text() == "Start"
      $.post "/",
        session:
          name: Pomodoro.session.name,
          action: "start",
          duration: $("#minutes").val()
    else
      $.post "/",
        session:
          name: Pomodoro.session.name,
          action: "stop",
