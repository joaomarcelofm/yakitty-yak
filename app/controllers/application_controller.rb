class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def default_url_options
    { host: ENV["HOST"] || "localhost:3000" }
  end

  protected

  def after_sign_in_path_for(resource)
    if resource.onboarded == false
      return edit_user_path(resource)
    else
      return dashboard_path
    end
  end
end
