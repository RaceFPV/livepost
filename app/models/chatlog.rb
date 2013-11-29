class Chatlog < ActiveRecord::Base
  has_many :chatpost
  validates :chatname, presence: true
  
  default_scope -> { order('created_at DESC')}
end
