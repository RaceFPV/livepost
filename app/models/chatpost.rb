class Chatpost < ActiveRecord::Base
  belongs_to :chatlog, dependent: :destroy
end
