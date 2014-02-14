class ChatlogsController < ApplicationController
  require 'json'

  def index
    publicchats = Chatlog.where(privatechat: false)
    @publicchats = publicchats.sort!
    privatechats = Chatlog.where(privatechat: true, permitted: true)
    privatechatsallowed = []
    myid = current_user.id
    privatechats.each do |x|
      x.permitted.include?(myid)
      privatechatsallowed << x
    end
    @privatechatsallowed = privatechatsallowed.sort!
  end

  def create
    chatlog = Chatlog.new(params[:chatlog])
    chatlog[:chatname] = params[:chatparams][:chatname]
    chatlog[:administrators] = [current_user.id]
    chatlog[:permitted] = [current_user.id]
    chatlog[:privatechat] = true
    chatlog[:created_by] = current_user.name

    if chatlog.save
      return redirect_to @chatlog, :flash => {:success => "Successfully created chat" }
    else
      redirect_to new_chatlog_path, :flash => {:error => "Chat name cannot be blank"}
    end
  end

    def createpublic
      if current_user.admin != true
        return redirect_to root_path, :flash => {:error => "Only administrators can create new public chats"}
      end
    chatlog = Chatlog.new(params[:chatlog])
    chatlog[:chatname] = params[:chatparams][:chatname]
    chatlog[:administrators] = [current_user.id]
    chatlog[:permitted] = [current_user.id]
    chatlog[:privatechat] = false
    chatlog[:created_by] = current_user.name

    if chatlog.save
      return redirect_to chatlog, :flash => {:success => "Successfully created chat" }
    else
      redirect_to new_chatlog_path, :flash => {:error => "Chat name cannot be blank"}
    end
  end

  def new
    chatlog = Chatlog.new
  end

  def show
    @chat ||= Chatlog.find(params[:id])
    @posts ||= @chat.chatpost.includes(:user)
    current_user.update_attribute(:lastseen, DateTime.now)
    @usershere ||= User.where("lastseen > ?", 5.minutes.ago)
    @usershere.sort!
  end

  def update
    @chat ||= Chatlog.find(params[:id])
    post = ChatlogsHelper.makepost(@chat,params[:chatparams][:post],current_user)
    if post.nil? == false
      @post = post
      return render 'update'
    else
      return render :nothing => true
    end
  end

  def leftchat
    @chat ||= Chatlog.find(params[:id])
    return render 'leftchat'
  end

  def destroy
    Chatlog.find(params[:id]).destroy
    flash[:success] = "Chat deleted."
    return redirect_to root_path
  end
  
    private

  def post_params
    params[:chatparams].permit(:user_name, :user_id, :post)
  end

  
end