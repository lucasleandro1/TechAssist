class MobileDevice < ApplicationRecord
  belongs_to :client
  has_many :tickets

  
  validates :client_id, presence: true
end
