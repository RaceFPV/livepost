class StaticPagesController < ApplicationController
  #don't require login for these pages, as they are public
  skip_before_filter :require_login
  
  def home
  end

  def help
  end

  def about
  end
end
