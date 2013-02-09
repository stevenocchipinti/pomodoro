var Notifications = {

  setup: function() {
    $("a#permission-request").click(function requestPermission() {
      window.webkitNotifications.requestPermission();
      $("#permission-request").hide();
    });
    if (window.webkitNotifications.checkPermission() !== 0) {
      $("#permission-request").slideDown("slow");
    }
  },

  show: function(title, text) {
    var icon = "icon.jpg";
    var snd = new Audio("notification.wav");
    if (window.webkitNotifications.checkPermission() == 0) {
      window.webkitNotifications.createNotification(icon, title, text).show();
    }
    snd.play();
  }

};
