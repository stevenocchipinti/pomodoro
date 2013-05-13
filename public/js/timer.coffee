Pomodoro.Timer = (options) ->

  duration: 0
  countdown: 0
  interval: null

  # ============================================================
  # Callbacks to be set from the constructor
  # ============================================================
  onStart: -> options.onStart?()
  onStop: -> options.onStop?()
  onUpdate: (status) -> options.onUpdate?(status)
  onComplete: -> options.onComplete?()

  # ============================================================

  setDuration: (minutes) ->
    @duration = minutes * 60
    @update()

  setSecondsLeft: (seconds_left) ->
    @countdown = seconds_left
    @duration = seconds_left unless @duration
    @update()

  reset: ->
    @setSecondsLeft(@duration)

  start: (onComplete) ->
    @update()
    @onStart()

    @interval = setInterval ( =>
      @tick()
    ), 1000

  tick: ->
    @countdown = @countdown - 1
    @update()
    if @countdown <= 0
      @stop()
      @onComplete()

  stop: ->
    clearInterval @interval
    @reset()
    @update()
    @onStop()

  update: ->
    @onUpdate({
      secondsLeft: @countdown,
      timeLeft: @timeLeft(),
      percentageLeft: @percentageLeft(),
    })

  # ============================================================

  timeLeft: ->
    m = parseInt(@countdown / 60)
    s = parseInt(@countdown - m * 60)
    s = "0#{s}" if s.toString().length == 1
    "#{m}:#{s}"

  percentageLeft: ->
    (@countdown / @duration) * 100
