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


An alternative approach
-----------------------

In order to overcome out of sync, client side clocks caveat, the server could
use websockets and a background job to broadcast exactly what to display on the
timer every second (while it is running) and another event for the notification
it self. This would mean regardless of the users clock, timezones, etc. the
timer would be synchronised, but this will require a background job per session
and a lot more websockets messages.

Possible gems that could help are:
* **Thin, Puma, etc.** - a webserver that supports streaming responses could be
  used to host the websockets server, use Server Sent Events (more widely
  supported), etc.
* **Suckerpunch** - for async jobs in a single process
