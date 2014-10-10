class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :set_remote_host
  protect_from_forgery with: :null_session
  def set_remote_host
    @host = "https://api.sendhub.com/v1/contacts/?username=2026446686\&api_key=ba7b9364f169359359837c4458172f208bee5579"
  end
end
