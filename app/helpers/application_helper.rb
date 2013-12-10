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
  