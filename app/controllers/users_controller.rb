class UsersController < ApplicationController
	before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
	before_action :correct_user, only: [:edit, :update]
	before_action :admin_user, only: :destroy
	skip_before_filter :require_login, :only => [:new, :create]
	
  def index
		@user
	end

	def show
    # TODO: Redirect to canonical lins if slugs change
  # see: http://code-worrier.com/blog/custom-slugs-in-rails/
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
      #send an alert notice to the user
      flash[:success] = "Welcome to the Livepost.io community!"
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
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].update(:location => params[:location]) if params[:user][:location].present?
    params[:user].update(:facebook => params[:facebook]) if params[:user][:facebook].present?
    params[:user].update(:linkedin => params[:linkedin]) if params[:user][:linkedin].present?
    params[:user].update(:twitter_id => params[:twitter_id]) if params[:user][:twitter_id].present?
    @user.save
            
    if @user.update_attributes(user_params)
  flash[:success] = "Profile updated"
  redirect_to @user
else
      @users = User.find(:all) 
  render 'edit'
end
 	end

	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "User deleted."
		redirect_to root_path
	end



	private

	def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :twitter_id, :facebook, :linkedin, :location)
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


