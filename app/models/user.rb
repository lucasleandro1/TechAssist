class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :api

  has_many :tickets, dependent: :destroy
end
#Aqui estou garantindo que ao removeer um usuário seus tickets sejam removidos junto a ele