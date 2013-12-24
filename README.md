# README

Welcome to Livepost (alpha)!

This app is in active development and should not be used in production.

## Contributing

Help develop this app quickly by using a Linux Ruby on Rails dev box from [Nitrous.io](https://www.nitrous.io/join/5APYJlsd8Bo)

*NOTE: IF YOU HAVE GIT PULLED RECENTLY BE SURE TO `RAKE DB:RESET`!*

### Nitrous.io

1. Go to [Nitrous.io](https://www.nitrous.io/join/5APYJlsd8Bo) and sign up for a free account, select Rails as the box type.
2. Once the box has been created, click on 'Boxes' in the top right, click you newly created box to expand, click Recal Public Key and add it to your Github account.
3. Click IDE to go to you Web IDE and in the console, type `cd workspace`
4. Come back to Github and click Fork in upper right, to fork repo.
5. Back in the console, type `git clone git@github.com:[your-github-username]/livepost.git`
6. In the console, type `cd livepost` and `bundle install --without production`
7. In the console, type `git config --global user.email "[your@email.com]"`
8. In the console, type `git config --global user.name "[your-real-name]"`
9. Edit the README file (add a space or something at the end) and make sure you can `git add .`, `git commit -m "Touched README."`, and `git push origin master`
10. If your push is successful, you are ready to start developing Livepost on Rails!
11. Delete the Fork from Settings in the repository to discard and start the process over again but this time implement something useful to the project, don't forget to issue a Pull Request back to Master so your new feature is implemented!

*NOTE: If you want to run the chat backend locally: In a new console run `rackup private_pub.ru -s thin -E production` to load up `faye/private_pub`*
