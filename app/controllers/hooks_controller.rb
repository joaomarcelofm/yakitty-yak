class HooksController < ApplicationController
  def push
    request_data(request.body.read)
    p request_data
    status 200
  end
end
