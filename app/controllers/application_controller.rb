class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #require a login to access web pages
  before_filter :require_login
  protect_from_forgery with: :exception
  #include the SessionsHelper which manages user signin/signout
  include SessionsHelper
end
