class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @disable_nav = true
  end

  def dashboard
    @request = Request.new
    @skills = Skill.all
  end

  def feed
    @request = Request.new
    @skills = Skill.all
  end
end
