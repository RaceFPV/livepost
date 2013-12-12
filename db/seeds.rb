# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# NOTE: Passwords match the name
User.create!([
  {
    name: "admin1",
    email: "admin1@test.com",
    password: "admin1",
    password_confirmation: "admin1",
    admin: true,
    lastseen: Time.now,
    twitter_id: nil,
    linkedin: nil,
    location: nil,
    facebook: nil
  },
  {
    name: "testuser1",
    email: "testuser1@test.com",
    password: "testuser1",
    password_confirmation: "testuser1",
    admin: false,
    lastseen: 2.hours.ago,
    twitter_id: "testuser1",
    linkedin: nil,
    location: nil,
    facebook: nil
  },
  {
    name: "testuser2",
    email: "testuser2@test.com",
    password: "testuser2",
    password_confirmation: "testuser2",
    admin: false,
    lastseen: 10.minutes.ago,
    twitter_id: "testuser2",
    linkedin: nil,
    location: "New York!",
    facebook: nil
  }
])

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
