class Ticket < ApplicationRecord
  belongs_to :mobile_device
  belongs_to :user
  enum pecas: [:bateria, :tela]
  enum sintoma: [:touch, :energia, :software]
end
