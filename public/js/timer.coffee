Pomodoro.timer =

  countdown: 0
  timer: null

  decrement: ->
    @countdown = @countdown - 1

  set: (givenTime) ->
    now = new Date().getTime()
    defaultTime = now + $("#minutes").val() * 60 * 1000
    notificationTime = givenTime or defaultTime
    seconds = parseInt((notificationTime - now) / 1000)
    defaultSeconds = parseInt((defaultTime - now) / 1000)
    @countdown = if seconds > 0 then seconds else defaultSeconds
    @updateDisplay()

  reset: ->
    @set()

  start: (onComplete) ->
    @updateDisplay()
    $("#toggle").text "Stop"
    $("#minutes").prop "disabled", true
    @timer = setInterval ( =>
      if @countdown <= 0
        @stop()
        return
      @decrement()
      @updateDisplay()
      if @countdown == 0
        onComplete()
    ), 1000

  stop: ->
    clearInterval @timer
    @reset()
    @updateDisplay()
    $("#toggle").text "Start"
    $("#minutes").prop "disabled", false

  updateDisplay: ->
    timeLeft = @timeLeft()
    percentageLeft = @percentageLeft()
    $("#countdown").html timeLeft
    document.title = "[#{timeLeft}] #{Pomodoro.applicationName}"
    if percentageLeft == 0 or percentageLeft == 100
      Piecon.reset()
    else
      Piecon.setProgress(100 - percentageLeft)

  timeLeft: ->
    m = parseInt(@countdown / 60)
    s = parseInt(@countdown - m * 60)
    s = "0#{s}" if s.toString().length == 1
    "#{m}:#{s}"

  percentageLeft: ->
    duration = Pomodoro.session.duration * 60
    (@countdown / duration) * 100

  is_running: ->
    Pomodoro.session.notificationTime &&
    Pomodoro.session.notificationTime > new Date().getTime()
