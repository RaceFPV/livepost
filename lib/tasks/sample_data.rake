namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_chatlogs
    make_chatposts
  end
end

def make_users
  # Create administrator
  admin = User.create!(name: "admin1",
                        email: "admin1@test.com",
                        password: "admin1",
                        password_confirmation: "admin1",
                        admin: true)
  
  # Create members
  5.times do |n|
    name = "Testuser#{n+1}"
    email = "testuser#{n+1}@test.com"
    password = "testuser#{n+1}"
    User.create!(name: name,
                 email: email,
                 password: password,
                 password_confirmation: password)
  end
end

def make_chatlogs
  Chatlog.create!([
    {
      chatname: "Test Public Chat 1",
      administrators: ["admin1@test.com"],
      privatechat: false,
      permitted: ["admin1@test.com"]
    },
    {
      chatname: "Test Public Chat 2",
      administrators: ["testuser2@test.com"],
      privatechat: false,
      permitted: ["testuser2@test.com"]
    },
    {
      chatname: "Test Private Chat 1",
      administrators: ["testuser2@test.com"],
      privatechat: true,
      permitted: ["testuser2@test.com"]
    },
    {
      chatname: "Test Private Chat 2",
      administrators: ["testuser2@test.com", "testuser1@test.com"],
      privatechat: true,
      permitted: ["testuser2@test.com", "admin1@test.com", "testuser1@test.com"]
    }
  ])
end

def make_chatposts
  Chatpost.create!([
    {
      post: "Admin post",
      username: "admin1",
      chatlog_id: 1
    },
    {
      post: "Test user 1 post",
      username: "testuser1",
      chatlog_id: 1
    },
    {
      post: "Test user 2 post",
      username: "testuser2",
      chatlog_id: 2
    },
    {
      post: "Test user 2 private post",
      username: "testuser2",
      chatlog_id: 3
    },
    {
      post: "Test user 2 private post 2",
      username: "testuser2",
      chatlog_id: 4
    },
    {
      post: "Admin private post",
      username: "admin1",
      chatlog_id: 4
    },
    {
      post: "Test user 1 private post 2",
      username: "testuser1",
      chatlog_id: 4
    }
  ])
end
