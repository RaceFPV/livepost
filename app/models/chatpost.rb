class Chatpost < ActiveRecord::Base
  belongs_to :chatlog, dependant: :destroy
end
