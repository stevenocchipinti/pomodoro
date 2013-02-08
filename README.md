POMODORO TIMER
==============

Status
------

Not ready


Description
-----------

A simple pomodoro timer

TODO List
---------

Things I would like to get done for the first version:
* Refactor JS to make it more OO
* Make it look nicer

Future version
--------------

Having 'start' and 'stop' events propogate to all connected clients would be
nice and WebSockets may provide the ideal mechanism for this!

* A client sends a 'start' ajax POST request to the server with a future notificationTime
  * The server sends the same 'start' event with that notificationTime to all connected clients
  * All connected clients start a local countdown timer
* A client sends a 'stop' ajax POST request to the server
  * Server sends the same 'stop' event to all connected clients
  * All connected clients stop their local countdown timers
* If a timer expires, a notification is produced (all happens client side)
* If a new client joins half way through a timer, it is automatically started
* If a new client joins after a timer has expired, it should ignore the past notificationTime

This approach means the server does not have to keep track on the time and send events when timers expire.
The sinatra app is very simple and doesn't require any background tasks, schedulers, cron, etc.
