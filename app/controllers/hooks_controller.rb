class HooksController < ApplicationController
  # authentication
  skip_before_action :authenticate_user!, only: :push
  # verify csrf
  skip_before_action :verify_authenticity_token, only: :push

  def push
    if params["token"] && params["token"] == ENV['VERIFICATION_TOKEN']
      render json: { text: "All Good" }, status: :ok
    end
    if params["payload"]
      json_payload = params["payload"]
      payload = JSON.parse(json_payload)
      if payload["actions"]
        status = payload["actions"][0]["name"]
        id = payload["actions"][0]["value"]

        request = Request.find(id)

        if status == "accept"
          request.accepted!
          text = "Thank you for accepting. You'll receive your meeting ASAP"
        elsif status == "reject"
          request.rejected!
          text = "Thank you. This will be routed to another network member"
        end

        render json: { text: text}, status: :ok
      end
    end

  end
end
