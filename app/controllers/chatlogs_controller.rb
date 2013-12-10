class ChatlogsController < ApplicationController
  require 'json'
  
def new
  @chatlog = Chatlog.new
end


def create
  @chatlog = Chatlog.new(params[:chatlog])
  @chatlog[:chatname] = params[:chatparams][:chatname]
  @chatlog[:administrators] = [nil, current_user.email]
  if @chatlog.save
  redirect_to @chatlog, :flash => {:success => "Successfully created chat" }
  else
  redirect_to new_chatlog_path, :flash => {:error => "Chat name cannot be blank"}
  end
end

def update
  @chatlog = Chatlog.find(params[:id])
  @chatpost = @chatlog.chatpost.new(params[:chatpost])
  @chatpost[:username] = current_user.name
  @chatpost[:post] = params[:chatparams][:post]
  @chat = @chatlog
  @chatposts = @chatlog.chatpost.all
  respond_to do |format|
    if @chatpost.save
    flash[:success] = "Successfully sent message"
    format.html { redirect_to @chatlog }
    format.js   {}
    end
   end

end

def show
  @chat = Chatlog.find(params[:id])
  @chatposts = @chat.chatpost.all
  @chatsubscribe = "/chatlog/#{@chat.id}/update" 
  @chatshow = "/chatposts/show"
  @users = User.all
  current_user.update_attribute(:lastseen, DateTime.now)
  @usershere = User.find :all, :conditions => ["lastseen > ?",5.minutes.ago.to_s(:db)]
  @usershere.sort!
end
  
def index
  @chats = Chatlog.all
end

def destroy
    Chatlog.find(params[:id]).destroy
    flash[:success] = "Chat deleted."
    redirect_to chatlogs_path
end

end