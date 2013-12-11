# README

Welcome to Livepost (alpha)!

This app is in active development and should not be used in production.

## Development

Help develop this app quickly by using a Linux Ruby on Rails dev box from [Nitrous.io](https://www.nitrous.io/join/5APYJlsd8Bo)

*NOTE: IF YOU HAVE GIT PULLED RECENTLY BE SURE TO `RAKE DB:MIGRATE`!*

### Nitrous.io

1. Go to [Nitrous.io](https://www.nitrous.io/join/5APYJlsd8Bo) and sign up for a free account, select Rails as the box type.
2. Once the box has been created, click on 'boxes' in the top right, expand your newly created box, reveil the ssh key, and add it to your github account.
3. In the console, type `cd workspace`
4. In the console, type `git clone git@github.com:slacker87/livepost.git`
5. In the console, type `cd livepost`
6. In the console, type `git config --global user.email "youremail@youremail.com"`
7. In the console, type `git config --global user.name "yourname"`
8. In the console, run `bundle install`
9. Touch this readme file (add a space or something) and make sure you can `git add .`, `git commit -am "touch"`, and `git push origin master`
10. If your push is successful, you are ready to start developing Livepost on Rails!

*NOTE: If you want to run the chat backend locally: In a new console run `rackup private_pub.ru -s thin -E production` to load up `faye/private_pub`*
