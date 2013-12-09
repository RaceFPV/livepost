module UsersHelper
  
    # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  def twitter_for(user)
  	twitter_url = "https://www.twitter.com/#{twitter_id}"
  end

  def facebook_for(user)
  	facebook_url = "#{facebook}"
  end

  def linkedin_for(user)
	linkedin_url = "#{linkedin}"
  end
  
end
