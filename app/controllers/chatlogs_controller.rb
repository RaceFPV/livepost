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
    @chatlog[:privatechat] = true
    @chatlog[:created_by] = current_user.name
    
    if @chatlog.save
      return redirect_to @chatlog, :flash => {:success => "Successfully created chat" }
    else
      redirect_to new_chatlog_path, :flash => {:error => "Chat name cannot be blank"}
    end
  end
  
    def createpublic
      if current_user.admin != true
        return redirect_to root_path, :flash => {:error => "Only administrators can create new public chats"}
      end
    @chatlog = Chatlog.new(params[:chatlog])
    @chatlog[:chatname] = params[:chatparams][:chatname]
    @chatlog[:administrators] = [current_user.id]
    @chatlog[:permitted] = [current_user.id]
    @chatlog[:privatechat] = false
    @chatlog[:created_by] = current_user.name
    
    if @chatlog.save
      return redirect_to @chatlog, :flash => {:success => "Successfully created chat" }
    else
      redirect_to new_chatlog_path, :flash => {:error => "Chat name cannot be blank"}
    end
  end
  
  def new
    @chatlog = Chatlog.new
  end
  
  def show
    @chat ||= Chatlog.find(params[:id])
    @posts ||= @chat.chatpost
    @chatsubscribe ||= "/#{@chat}/update" 
    @chatshow ||= "/chatposts/show"
    @usersubscribe ||= "/#{@chat}/"
    current_user.update_attribute(:lastseen, DateTime.now)
    @usershow ||= "/chatlogs/usershow"
    @usershere = User.where("lastseen > ?", 5.minutes.ago)
    @usershere.sort!
  end
  
  def update
    @chatlog ||= Chatlog.find(params[:id])
    @chatpost = @chatlog.chatpost.new(params[:chatpost])
    @chatpost[:user_name] = current_user.name
    @chatpost[:user_id] = current_user.id
    @chatpost[:post] = params[:chatparams][:post]
    @chat ||= @chatlog
    @chatposts ||= @chatlog.chatpost
    current_user.update_attribute(:lastseen, DateTime.now)
    if @chatpost.save
    return render 'update'
    else
    return render 'update_error'
    end
  end
  
  def destroy
    Chatlog.find(params[:id]).destroy
    flash[:success] = "Chat deleted."
    return redirect_to root_path
  end
end