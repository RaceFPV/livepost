class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #require a login to access web pages
  before_filter :require_login
  #include the SessionsHelper which manages user signin/signout
  include SessionsHelper
end
