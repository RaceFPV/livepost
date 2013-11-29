class ChatsController < ApplicationController
  
def new
  @chatlog = Chatlog.new
end


def create
  @chatlog = Chatlog.new(params[:chatlog])
  @chatlog[:chatname] = params[:chatparams][:chatname]
  @chatlog.save
  redirect_to @chatlog, :flash => {:success => "Successfully created chat" } 
end
  
def update
  @chatpost = Chatpost.new(params[:chatpost])
  @chatpost[:username] = params[:chatparams][:username]
  @chatpost[:post] = params[:chatparams][:post]
  @chatpost.save
  flash[:success] = "Successfully sent message"
  
    respond_to do |format|
    format.html { redirect_to chat_path(params[:chat_id]) }
    format.js
  end
end

def show
  @chat = Chatlog.find(params[:id])
  @chatposts = @chat.chatpost.all
end
  
def index
  @chats = Chatlog.all
end
  
  
end
