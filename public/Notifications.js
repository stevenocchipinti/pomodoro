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
    var icon = "icon.jpg";
    new Audio("notification.wav").play();
    if (window.webkitNotifications) {
      if (window.webkitNotifications.checkPermission() == 0) {
        window.webkitNotifications.createNotification(icon, title, text).show();
      }
    } else {
      alert(text);
    }
  }

};
