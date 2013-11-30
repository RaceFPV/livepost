class ChatlogsController < ApplicationController

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
  @chatpost[:username] = params[:chatparams][:username]
  @chatpost[:post] = params[:chatparams][:post]
  
  #redirect_to @chatlog, :flash => {:success => "Successfully sent message"}
  # stuff for ajax, not yet working
    flash[:success] = "Successfully sent message via redirect_to"
  respond_to do |format|
    if @chatpost.save
    flash[:success] = "Successfully sent message via redirect_to"
    format.html { redirect_to @chat }
    format.js   {}
    format.json { render json: @chatpost, status: :created, location: @chatpost}
    end
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