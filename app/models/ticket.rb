class Ticket < ApplicationRecord
  belongs_to :mobile_device
  belongs_to :user

end
