class UsersController < ApplicationController
	before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
	before_action :correct_user, only: [:edit, :update]
	before_action :admin_user, only: :destroy
	skip_before_filter :require_login, :only => [:new, :create]
	
  def index
		@user
	end

	def show
		@user = User.find(params[:id])
	end

	def new
    #create a new variable to hold User params
		@user = User.new
	end

	def create
    #take the form parameters and create a new user from them
    @user = User.new(user_params)
    #if the new user saves to the database do this
    if @user.save
      #sign in as the user
      sign_in @user
      #tie the users session to the newly created user account
      session[:user_id] = @user.id
      #redirect the user to their profile
      redirect_to root_path
      #if the user doesnt save to the database, re-show the registration form
    else
      render 'new'
    end
	end

	def edit
		@user = User.find(params[:id])
	end

  def update
    @user = User.find(params[:id])
    #if we aren't updating the password, don't ask us about it
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank?
    #updates the password if the password field isn't blank
    user_identity = Identity.find_by_email(@user.email)
    if params[:user][:password]
      #set the identity password to the params from the form
      user_identity.password = params[:user][:password]
      #make sure its confirmed
      user_identity.password_confirmation = params[:user][:password_confirmation]
      #if it saves, keep going through the controller
      if !user_identity.save
      #if it doesn't save, flash an error and re-render the page
        flash[:error] = "Error changing password"
        return render 'edit'
      end
    end

    #update Identity as well as User model for the username
    if params[:user][:name] != @user.name
      if @user.provider == "identity"
        #set the user name to the field entry
        user_identity.name = params[:user][:name]
        #if it saves, start trying to save the user field
        if user_identity.save
          #set the user name to the field params
          @user[:name] = params[:user][:name]
          #if the user saves, alert that it was successful and redirect back to the profile page
          if @user.save
            #notify user of the update
           flash[:success] = "updated successfully"
           #toss them back to their profile
            return redirect_to @user
          #if the save fails, warn the user and re-render the page
          else
            flash[:error] = "Username already exists"
            return render 'edit'
          end
        else
          flash[:error] = "Username already exists"
          return render 'edit'
        end
      else
        @user[:name] = "#{params[:user][:name]}"
        if @user.save
          #notify user of the update
          flash[:success] = "Profile updated"
          #toss them back to their profile
          return redirect_to @user
          #if the save fails, warn the user and re-render the page
        else
          flash[:error] = "Username already exists"
          return render 'edit'
        end
      end
    end
      #save our changes to the user model
      if @user.update_attributes(user_params)
        #notify user of the update
        flash[:success] = "Profile updated"
        #toss them back to their profile
        return redirect_to @user
      else
        flash[:error] = "Username already exists"
        return render 'edit'
      end
  end

	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "User deleted."
		redirect_to root_path
	end



	private

	def user_params
    params[:user].permit(:name, :email, :twitter_id, :facebook, :linkedin, :location)
	end

	# Before filters

	def signed_in_user
		unless signed_in?
			store_location
			redirect_to signin_url, notice: "Please sign in."
		end
	end

	def correct_user
		@user = User.find(params[:id])
		redirect_to(root_url) unless current_user?(@user)
	end

	def admin_user
		redirect_to(root_url) unless current_user.admin?
	end
end