POMODORO TIMER
==============

Status
------

V1.0 Working!


Description
-----------

A simple pomodoro timer where the server stores the notification time so that
all clients that connect will be notified at the same time.
The notifications use Webkit's notifications (with fallback to alert) and HTML5
audio playback.


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
