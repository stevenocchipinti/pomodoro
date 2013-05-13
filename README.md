POMODORO TIMER
==============

Status
------

Working!

[![Code Climate](https://codeclimate.com/github/stevenocchipinti/pomodoro.png)](https://codeclimate.com/github/stevenocchipinti/pomodoro)


Description
-----------

A simple pomodoro timer where the server stores the notification time so that
all clients that connect will be notified at the same time.
The notifications use Webkit's notifications (with fallback to alert) and HTML5
audio playback.


Getting started
---------------

1. Clone the repository
2. Run `bundle install`
3. Configure the environment variables in `script/environment.sh`
4. `source script/environment.sh`
5. `bundle exec ruby application.rb`


TODOs
-----

- Allow JS to set duration and secondsLeft independently
- Experiment with a JavaScript framework to make it easier to read (maybe)


Caveats
-------

1. Multiple clients can use this at once and they will share a notification
   time, but this time is based on the clients system clock, so if the clients
   clocks are different, the notifications will be out of sync.
