class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :api

  has_many :tickets, dependent: :destroy
  has_many :mobile_devices, through: :tickets
  has_many :clients, through: :mobile_devices

end
