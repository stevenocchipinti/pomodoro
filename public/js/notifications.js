Pomodoro.notifications = {

  setup: function() {
    if (window.webkitNotifications) {
      $("a#permission-request").click(function requestPermission() {
        window.webkitNotifications.requestPermission();
        $("#permission-request").hide();
      });
      if (window.webkitNotifications.checkPermission() !== 0) {
        $("#permission-request").slideDown("slow");
      }
    }
  },

  show: function(title, text) {
    var icon = "images/icon.jpg";
    new Audio("audio/notification.wav").play();
    if (window.webkitNotifications) {
      if (window.webkitNotifications.checkPermission() == 0) {
        var popup = window.webkitNotifications.createNotification(icon, title, text);
        popup.show();
        setTimeout(function() {
          popup.cancel();
        }, 5000);
      }
    } else {
      alert(text);
    }
  }

};
