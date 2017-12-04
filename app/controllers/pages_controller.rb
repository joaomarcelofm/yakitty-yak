class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @disable_nav = true
  end

  def dashboard
    @disable_nav = true
    @request = Request.new
  end
end
