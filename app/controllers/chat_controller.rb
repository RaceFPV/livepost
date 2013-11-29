class ChatController < ApplicationController
  
def new
  @chatlog = Chatlog.new
end


def create
  @chatlog = Chatlog.new(params[:chat])
  @chatlog.chathistory = params[:chattext]
  @chatlog.save
  flash[:success] = "Successfully sent message"
  respond_to do |format|
    format.html { redirect_to chat_path(params[:chat_id]) }
    format.js
  end
end
  
def show
  @chat = Chatlog.find(params[:id])
end
  
def index
  @chats = Chatlog.all
end
  
  
end
