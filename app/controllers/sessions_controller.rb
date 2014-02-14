class SessionsController < ApplicationController
	def new
	end

  #used for allowing users to sign in
  def create
    #let the user login using omniauth
    user = User.from_omniauth(env["omniauth.auth"]) rescue nil
    if user
      #change the user_id to the new one gotten by logging in
      session[:user_id] = user.id
      session[:guest_user_id] = nil
      if user.created_at == user.updated_at
        return redirect_to root_path, :flash => {:notice => "Welcome to Livepost.io, #{user.name}!"}
      else
        #redirect to the users profile page if we dont save anything
        return redirect_to root_path, :flash => {:notice => "Welcome back, #{user.name}!"}
      end
      else
       return redirect_to root_path, :flash => {:error => "error signing in, please try again with a unique name/email"}
    end
  end

	def destroy
	  session.destroy
		return redirect_to root_url
	end

	  #if the user fails to sign in properly, redirect and alert them
  def failure
    return redirect_to root_url, :flash => {:error => "Error logging in"}
  end
end