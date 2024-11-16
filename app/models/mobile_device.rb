class MobileDevice < ApplicationRecord
  belongs_to :client
  belongs_to :user
  has_many :tickets, dependent: :destroy


  validates :client_id, :imei, :serial, :modelo, :marca, presence: true
  validates :imei, uniqueness: true
end
