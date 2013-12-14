class ChatlogsController < ApplicationController
  require 'json'
  
  def index
    @publicchats = Chatlog.where(privatechat: false)
    @publicchats.sort!
    privatechats = Chatlog.where(privatechat: true)
    @privatechatsallowed = []
    privatechats.each do |x|
      if x != nil and x.permitted != nil
        x.permitted.each do |y|
          if y == current_user.id
            @privatechatsallowed << x
          end
        end
      end
    end
    @privatechatsallowed.sort!
  end
  
  def create
    @chatlog = Chatlog.new(params[:chatlog])
    @chatlog[:chatname] = params[:chatparams][:chatname]
    @chatlog[:administrators] = [current_user.id]
    @chatlog[:permitted] = [current_user.id]
    @chatlog[:privatechat] = params[:chatparams][:privatechat]
    
    if @chatlog.save
      redirect_to @chatlog, :flash => {:success => "Successfully created chat" }
    else
      redirect_to new_chatlog_path, :flash => {:error => "Chat name cannot be blank"}
    end
  end
  
  def new
    @chatlog = Chatlog.new
  end
  
  def show
    @chat = Chatlog.find(params[:id])
    @posts = @chat.chatpost
    current_user.update_attribute(:lastseen, DateTime.now)
    @usershere = User.where("lastseen > ?",5.minutes.ago.to_s(:db))
    @usershere.sort!
    respond_to do |format|
      format.html {}
      format.js {}
    end
  end
  
  def update
    @chatlog = Chatlog.find(params[:id])
    @chatpost = @chatlog.chatpost.new(params[:chatpost])
    @chatpost[:user_name] = current_user.name
    @chatpost[:user_id] = current_user.id
    @chatpost[:post] = params[:chatparams][:post]
    @chat = @chatlog
    @chatposts = @chatlog.chatpost
    respond_to do |format|
      if @chatpost.save
        format.html { redirect_to @chatlog }
        format.js   {}
      end
    end
  end
  
  def destroy
    Chatlog.find(params[:id]).destroy
    flash[:success] = "Chat deleted."
    redirect_to chatlogs_path
  end
end