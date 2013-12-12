class StaticPagesController < ApplicationController
  #don't require login for these pages, as they are public
  skip_before_filter :require_login
  
  def home
    # If visitor is signed in, redirect to Chats index
    if signed_in? then
      # TODO: Would be neat to use render rather than redirect_to
      # so URL doesn't change, similiar to Facebook.
      redirect_to chatlogs_url
    end
  end

  def help
  end

  def about
  end
end
