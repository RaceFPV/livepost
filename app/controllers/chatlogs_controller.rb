class ChatlogsController < ApplicationController
  require 'json'

  def index
    @publicchats = Chatlog.where('privatechat = ?', false).order('chatname DESC') rescue nil
    @privatechatsallowed = Chatlog.where('privatechat = ? AND permitted LIKE ?', true, "%#{current_user.id}%").order('chatname DESC') rescue nil
  end

  def create
    chatlog = Chatlog.new(params[:chatlog])
    chatlog[:chatname] = params[:chatparams][:chatname]
    chatlog[:administrators] = current_user.id
    chatlog[:permitted] = current_user.id
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
    chatlog[:administrators] = current_user.id
    chatlog[:permitted] = current_user.id
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
    @usershere ||= User.where("lastseen > ?", 5.minutes.ago).order('name DESC')
  end

  def update
    @chat ||= Chatlog.find(params[:id])
    if params[:chatparams][:post] != ""
      post = ChatlogsHelper.makepost(@chat,params[:chatparams][:post],current_user)
    end
    if post.nil? == false
      @post = post
      return render 'update'
    end
    return render :nothing => true
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

  
end