Pomodoro.timer = {

  countdown: 0,
  timer: null,

  decrement: function() {
    this.countdown = this.countdown - 1;
  },

  set: function(notificationTime) {
    var now = new Date().getTime();
    var defaultTime = now + $("#minutes").val() * 60 * 1000;
    var then = notificationTime || defaultTime;
    var seconds = parseInt((then - now) / 1000);
    var defaultSeconds = parseInt((defaultTime - now) / 1000);
    this.countdown = seconds > 0 ? seconds : defaultSeconds;
    this.updateDisplay();
  },

  reset: function() {
    this.set()
  },

  start: function(onComplete) {
    var that = this;
    this.updateDisplay();
    $("#toggle").text("Stop");
    $("#minutes").prop("disabled", true);
    this.timer = setInterval(function() {
      if (that.countdown <= 0) {
        that.stop();
        return;
      }
      that.decrement();
      that.updateDisplay();
      if (that.countdown == 0) {
        onComplete();
      }
    }, 1000);
  },

  stop: function() {
    clearInterval(this.timer);
    this.reset();
    this.updateDisplay();
    $("#toggle").text("Start");
    $("#minutes").prop("disabled", false);
  },

  updateDisplay: function() {
    var m = parseInt(this.countdown / 60);
    var s = parseInt(this.countdown - m * 60);
    if (s.toString().length == 1) s = "0" + s;
    $("#countdown").html(m + ":" + s);
    document.title = "[" + m + ":" + s + "] " + Pomodoro.applicationName;
  }

};
