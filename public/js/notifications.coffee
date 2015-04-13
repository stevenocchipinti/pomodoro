Pomodoro.notifications =

  setup: ->
    if window.Notification
      $("a#permission-request").click ->
        Notification.requestPermission()
        $("#permission-request").hide()
      if Notification.permission == 'default'
        $("#permission-request").slideDown "slow"

  show: (title, text) ->
    icon = "images/icon.jpg"
    new Audio("audio/notification.wav").play()
    if Notification && Notification.permission == "granted"
        popup = new Notification(title, body: text, icon: icon)
        setTimeout ( ->
          popup.close()
        ), 5000
    else
      alert text
