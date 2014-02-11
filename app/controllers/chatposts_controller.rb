class ChatpostsController < ApplicationController
  
def create
  @chatlog = Chatlog.find(params[:id])
  @chatpost = @chatlog.chatpost.new(params[:chatpost])
  @chatpost[:username] = current_user.name
  @chatpost[:post] = params[:chatparams][:post]
  @chatpost[:post] = auto_link(@chatpost[:post])
  @chat = @chatlog
  
  @chatposts = @chatlog.chatpost
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

def destroy
    @chatlog ||= Chatlog.find(params[:chatlog_id])
    @chatpost = @chatlog.chatpost.find(params[:id])
    @chatposts ||= @chatlog.chatpost
    @chatpostid = @chatpost.id.to_s
    @chat ||= @chatlog
    @chatpost.destroy
    puts "deleting post: #{@chatpost.id}"
    render 'destroy'
end

end