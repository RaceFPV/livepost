class ChatpostsController < ApplicationController

  def new
    
  end
  
  def create
  @chatlog = Chatlog.find(params[:id])
  @chatpost = @chatlog.chatpost.new(params[:chatpost])
  @chatpost[:username] = current_user.name
  @chatpost[:post] = params[:chatparams][:post]
  
  @chatposts = @chatlog.chatpost.all
  
  #redirect_to @chatlog, :flash => {:success => "Successfully sent message"}
  # stuff for ajax, not yet working
    flash[:success] = "Successfully sent message"
  respond_to do |format|
    if @chatpost.save
    flash[:success] = "Successfully sent message"
    format.html { redirect_to @chatlog }
    format.js   {}
    format.json { render json: @chatpost, status: :created, location: @chatpost}
    end
    end
end

def show
  @chatlog = Chatlog.find(params[:id])
  @chatpost = @chatlog.chatpost.new(params[:chatpost])
end
end