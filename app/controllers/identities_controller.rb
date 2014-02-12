class IdentitiesController < ApplicationController
  #used for the new user signup page
  def new
    @identity = env['omniauth.identity']
  end
end
