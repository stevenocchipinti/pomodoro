Pomodoro.notifications =

  setup: ->
    if window.webkitNotifications
      $("a#permission-request").click ->
        window.webkitNotifications.requestPermission()
        $("#permission-request").hide()
      if window.webkitNotifications.checkPermission() != 0
        $("#permission-request").slideDown "slow"

  show: (title, text) ->
    icon = "images/icon.jpg"
    new Audio("audio/notification.wav").play()
    if window.webkitNotifications
      if window.webkitNotifications.checkPermission() == 0
        popup = window.webkitNotifications.createNotification icon, title, text
        popup.show()
        setTimeout ( ->
          popup.cancel()
        ), 5000
    else
      alert text
