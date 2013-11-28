module ApplicationHelper

  #Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Livepost"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
  
  

  def broadcast(channel, &block)
    message = {:channel => channel, :data => capture(&block), :ext => {:auth_token => FAYE_TOKEN}}
    uri = URI.parse("http://localhost:9292/faye")
    Net::HTTP.post_form(uri, :message => message.to_json)
  end


  
  # for pretty alert messages using the flash command
   def bootstrap_class_for flash_type
    case flash_type
    when :success
    "alert-success"
    when :error
    "alert-danger"
    when :alert
    "alert-danger"
    when :notice
    "alert-info"
    when :warning
    "alert-warning"
    else
    flash_type.to_s
end
end
 
 
end
  