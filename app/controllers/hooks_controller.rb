class HooksController < ApplicationController
  def request_callback
    if params[:request].present
    create_request


  end

end
