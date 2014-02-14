class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #require a login to access web pages
  before_filter :initialize_user
  after_filter :user_activity
  protect_from_forgery with: :exception
  respond_to :html, :json
  #include the SessionsHelper which manages user signin/signout
  include SessionsHelper
  #rescue users if a save catastrophically fails
  rescue_from ActiveRecord::RecordNotUnique, :with => :getmeoutofhere

  def getmeoutofhere
    return redirect_to root_path, :flash => {:error => "Something went wrong, please try again later"}
  end

  def require_username
    redirect_to start_path if session[:user].blank? || session[:user].strip.blank?
  end
  # if user is logged in, return current_user, else return guest_user
  def current_or_guest_user
    if !session[:user_id] and !session[:guest_user_id]
        return create_guest_user
    elsif session[:user_id]
        return current_user
    else
        return guest_user
    end
  end

  # find guest_user object associated with the current session,
  # creating one as needed
  def guest_user
    # Cache the value the first time it's gotten.
    puts "guest user #{session[:guest_user_id]}"
    @cached_guest_user ||= User.where(:id => session[:guest_user_id]).first || create_guest_user

  rescue ActiveRecord::RecordNotFound # if session[:guest_user_id] invalid
     session[:guest_user_id] = nil
     guest_user
  end

  private

  def initialize_user
    current_or_guest_user
  end

  #used to find out who is online, when the user does anything, update the users modified_at field
  def user_activity
    user ||= User.find(current_character_hash[:user_id]) rescue nil
    touched = user.touch rescue nil
    if touched != nil
      puts "updated user activity for #{user.id}"
    else
      return
    end
  end

  #generate a guest user with a random username and password based on the current time and a random number
  def create_guest_user
    username = "guest_#{Time.now.to_i}#{rand(99)}"
    password = username
    user = User.create(:name => username, :email => "#{username}@livepost.io")
    if user.save(:validate => false)
      session[:guest_user_id] = user.id
      return user
    else
      return create_guest_user
    end
  end

  #find out who the current user is based on their saved cookie
  def current_user
    @current_user = User.find(session[:guest_user_id]) rescue nil
    if @current_user == nil
      @current_user = User.find(session[:user_id]) rescue nil
    end
    return @current_user
  end
  helper_method :current_user
end