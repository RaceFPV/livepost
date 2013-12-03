class StaticPagesController < ApplicationController
  skip_before_filter :require_login
  def home
  end

  def help
  end

  def about
  end
end
