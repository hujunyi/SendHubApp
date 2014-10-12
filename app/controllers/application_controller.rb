class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  private

  def base_url
    "https://api.sendhub.com/v1/"
  end
  def credentials
    "/?username=#{session[:username]}&api_key=#{session[:apikey]}"
  end
end
