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

* Allow the client to send a predefined time (in milliseconds) to the server to store
* Make the notification go off at that time from the client
  * On page ready, calculate number of seconds from `new Date().getTime()` to the value from the server
  * Notify in that many seconds
* Store multiple predefined times again IDs of somesort (user supplied string, short checksum, etc.)
* Make it look nice
