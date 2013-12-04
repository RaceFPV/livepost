class ChatpostsController < ApplicationController


def show
  @chatlog = Chatlog.find(params[:id])
  @chatpost = @chatlog.chatpost.new(params[:chatpost])
end


end