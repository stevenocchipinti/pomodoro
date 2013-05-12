jQuery ->

  Pomodoro.notifications.setup()

  # Setup a timer with actions to be performed on particular events
  timer = new Pomodoro.Timer
    onStart: ->
      $("#toggle").text "Stop"
      $("#minutes").prop "disabled", true
    onStop: ->
      $("#toggle").text "Start"
      $("#minutes").prop "disabled", false
    onUpdate: (status) ->
      console.log(status)
      $("#countdown").html status.timeLeft
      document.title = "[#{status.timeLeft}] #{Pomodoro.applicationName}"
      if status.percentageLeft == 0 or status.percentageLeft == 100
        Piecon.reset()
      else
        Piecon.setProgress(100 - status.percentageLeft)
    onComplete: ->
      Pomodoro.notifications.show("Pomodoro", "Pomodoro complete!")


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
