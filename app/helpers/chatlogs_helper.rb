module ChatlogsHelper
  
  def self.makepost(chat, post, user)
    mypost = chat.chatpost.new
    mypost.user_name = user.name
    mypost.user_id = user.id
    mypost.post = post
    mypost.save
    user.update_attribute(:lastseen, DateTime.now)
    return mypost
  end
  
  
end