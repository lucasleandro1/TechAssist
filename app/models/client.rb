class Client < ApplicationRecord
  has_many :mobile_devices, dependent: :destroy

  validates :nome, :cpf, :email, :telefone, presence: true
  validates :cpf, uniqueness: true
  belongs_to :user
end

