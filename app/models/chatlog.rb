class Chatlog < ActiveRecord::Base
  has_many :chatpost, dependent: :destroy
  validates :chatname, presence: true
  serialize :administrators
  serialize :permitted
  default_scope -> { order('created_at DESC')}
end
