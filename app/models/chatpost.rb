class Chatpost < ActiveRecord::Base
  belongs_to :chatlog
  belongs_to :user

  before_save { self.user_name ||= User.find(self.user_id).name }

  #default_scope -> {order('created_at ASC')}
end
