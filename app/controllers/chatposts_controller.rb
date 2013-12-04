class ChatpostsController < ApplicationController

def create
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
  @chatlog = Chatlog.find(params[:id])
end


end