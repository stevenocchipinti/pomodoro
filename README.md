POMODORO TIMER
==============

Status
------

Working!


Description
-----------

A simple pomodoro timer where the server stores the notification time so that
all clients that connect will be notified at the same time.
The notifications use Webkit's notifications (with fallback to alert) and HTML5
audio playback.


Caveats
-------

1. Multiple clients can use this at once and they will share a notification
   time, but this time is based on the clients system clock, so if the clients
   clocks are different, the notifications will be out of sync.
2. The clients will not poll the server to check for changes, this has to be
   done manually. So if clientA and clientB have already loaded the page, and
   clientA starts the timer, clientB will not know unless it refreshes the
   page. If a clientC connects half way through a timer, it will automatically
   start. The same behaviour applies for stopping the timer.


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

This approach means the server does not have to keep track of the time and send events when timers expire.
The server simply has to push events when it receives a POST request - no cron needed!
