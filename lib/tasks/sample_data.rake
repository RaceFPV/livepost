require 'open-uri'

namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_chatlogs
    make_chatposts
  end
end

def make_users
  # Random user detail generator API
  random_user_api = 'http://api.randomuser.me/0.2/'
  
  # Create administrator
  admin = User.create!(
    name: "admin1",
    email: "admin1@test.com",
    password: "admin1",
    password_confirmation: "admin1",
    admin: true
    )
  
  # Create members
  5.times do |n|
    random_user = ActiveSupport::JSON.decode(open(random_user_api))
    user = random_user['results'][0]['user']
    
    name = user['name']['first'] + " " + user['name']['last']
    email = "testuser#{n+1}@test.com"  # user['email']
    password = "testuser#{n+1}"        # user['md5_hash'],
    
    User.create!(
      name: name,
      email: email,
      password: password,
      password_confirmation: password
      )
  end
end

def make_chatlogs
  users = User.all
  Chatlog.create!([
    {
      chatname: "Test Public Chat 1",
      administrators: [users[1].email],
      privatechat: false,
      permitted: [users[1].email]
    },
    {
      chatname: "Test Public Chat 2",
      administrators: [users[2].email],
      privatechat: false,
      permitted: [users[2].email]
    },
    {
      chatname: "Test Private Chat 1",
      administrators: [users[2].email],
      privatechat: true,
      permitted: [users[2].email]
    },
    {
      chatname: "Test Private Chat 2",
      administrators: [users[1].email, users[2].email],
      privatechat: true,
      permitted: [users[1].email, users[2].email]
    }
  ])
end

def make_chatposts
  users = User.all
  Chatpost.create!([
    {
      post: "Admin post",
      username: users[0].name,
      chatlog_id: 1
    },
    {
      post: "Test user 1 post",
      username: users[1].name,
      chatlog_id: 1
    },
    {
      post: "Test user 2 post",
      username: users[2].name,
      chatlog_id: 2
    },
    {
      post: "Test user 2 private post",
      username: users[2].name,
      chatlog_id: 3
    },
    {
      post: "Test user 2 private post 2",
      username: users[2].name,
      chatlog_id: 4
    },
    {
      post: "Admin private post",
      username: users[0].name,
      chatlog_id: 4
    },
    {
      post: "Test user 1 private post 2",
      username: users[1].name,
      chatlog_id: 4
    }
  ])
end
