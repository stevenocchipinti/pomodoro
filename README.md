POMODORO TIMER
==============


[![Build Status](https://travis-ci.org/stevenocchipinti/pomodoro.svg?branch=master)](https://travis-ci.org/stevenocchipinti/pomodoro)
[![Code Climate](https://codeclimate.com/github/stevenocchipinti/pomodoro.png)](https://codeclimate.com/github/stevenocchipinti/pomodoro)


A simple pomodoro timer where the server keeps track of sessions and uses HTML5
server sent events to notify all connected clients of the status.
The notifications use Webkit's notifications (with fallback to alert) and HTML5
audio playback.


Getting started
---------------

1. Clone the repository
2. `bundle install`
3. `bundle exec rackup`
