module UsersHelper
  # Returns the Gravatar for the given user (see: http://gravatar.com/)
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag gravatar_url, alt: user.name, class: "gravatar"
  end
  
  def gravatar_url_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
  end

  def twitter_for(user)
    user.twitter_id ? "https://www.twitter.com/#{user.twitter_id}" : ""
  end

  def facebook_for(user)
  	#{user.facebook}
  end

  def linkedin_for(user)
	  #{user.linkedin}
  end
end
