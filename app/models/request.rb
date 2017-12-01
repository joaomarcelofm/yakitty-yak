class Request < ApplicationRecord
  belongs_to :user
  belongs_to :receiver, class_name: "User"
  serialize :matches


  def set_reciever
    User.find()

  end
end
