class StaticPagesController < ApplicationController
  #don't require login for these pages, as they are public
  skip_before_filter :require_login

  def home
    # If visitor is signed in, redirect to Chats index
    if current_user and !current_user.name.include?("guest_")
      @publicchats = Chatlog.where('privatechat = ?', false).order('chatname DESC') rescue nil
      @privatechatsallowed = Chatlog.where('privatechat = ? AND permitted LIKE ?', true, "%#{current_user.id}%").order('chatname DESC') rescue nil
      return render 'chatlogs/index'
    end
  end

end