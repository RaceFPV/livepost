class ChatlogsController < ApplicationController
  require 'json'
  
def new
  @chatlog = Chatlog.new
end


def create
  @chatlog = Chatlog.new(params[:chatlog])
  @chatlog[:chatname] = params[:chatparams][:chatname]
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
  @chatsubscribe = "/chatlog/#{@chat.id}/update" 
  @chatshow = "/chatposts/show"
  @chatposts = @chatlog.chatpost.all
  respond_to do |format|
    if @chatpost.save
      
  PrivatePub.publish_to(@chatsubscribe, render(@chatshow))
    flash[:success] = "Successfully sent message"
    format.html { redirect_to @chatlog }
    format.js   {}
    end
   end

end

def show
  @chat = Chatlog.find(params[:id])
  @chatposts = @chat.chatpost.all
  @users = User.all
end
  
def index
  @chats = Chatlog.all
end

end