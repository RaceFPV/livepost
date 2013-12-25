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
	  #redirect if we are already signed in
    if signed_in?
    flash[:notice] = "Already signed in"
    redirect_to root_path
    end
    #create a new variable to hold User params
		@user = User.new
	end

	def create
		@user = User.new(user_params)
    #Make the first user created a super user
    if User.count == 0
      @user[:super_user] = true
    else
      @user[:super_user] = false
    end
    if @user.save
			sign_in @user
			flash[:success] = "Welcome to LivePost!"
			redirect_to chatlogs_path
		else
			render 'new'
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
      params[:user].delete(:password) if params[:user][:password].blank?
    
    if @user.update_attributes(user_params)
  flash[:success] = "Profile updated"
  redirect_to @user
else
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


