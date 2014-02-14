class ChatpostsController < ApplicationController

def show
  @chatlog = Chatlog.find(params[:id])
end

def destroy
    chatlog ||= Chatlog.find(params[:chatlog_id])
    chatpost = chatlog.chatpost.find(params[:id])
    chatposts ||= chatlog.chatpost
    @chatpostid = chatpost.id.to_s
    @chat ||= chatlog
    chatpost.destroy
    render 'destroy'
end

end