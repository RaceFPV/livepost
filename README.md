== README

Welcome to livepost!

This app is in active development alpha mode


****  IF YOU HAVE GIT PULLED RECENTLY BE SURE TO 'RAKE DB:RESET' !!!!!


== Guides used:

For faye chat framework:

http://railscasts.com/episodes/260-messaging-with-faye?view=asciicast



== Installation

**** NOTE  faye and private_pub, the backend features for this application, will not build properly on a windows system so it is recommended that you use Linux or OS X when developing this app.

Needed for dev in *linux*: 'sudo apt-get install libsqlite3-dev'

After you bundle install be sure to run 'rackup private_pub.ru -s thin -E production' to load up faye/private_pub on your machine and allow AJAX/instant messaging
