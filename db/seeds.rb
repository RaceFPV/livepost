# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin_account_omni = [
    {
    name: %q[Admin],
      email: %q[admin@livepost.io],
      password: %q[password],
      password_confirmation: %q[password]
  }
]

pbar = ProgressBar.create( title: 'Seed Admin Omniauth Account', total: admin_account_omni.count, format: '%a |%b>>%i| %p%% %t [%c/%C done]')
admin_account_omni.each do |omni|
  Identity.create omni
  pbar.increment
end

user1 = Identity.find_by_name("Admin")

User.create do |user|
  user.uid = user1["id"]
  user.name = user1["name"]
  user.email = user1["email"]
  user.password_digest = user1.password_digest
  user.provider = "identity"
  user.admin = true
  user.super_user = true
end
