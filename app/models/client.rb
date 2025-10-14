class Client < ApplicationRecord
  belongs_to :user
  has_many :mobile_devices, dependent: :destroy

  validates :nome, :cpf, :email, :telefone, presence: true
  validates :cpf, uniqueness: { scope: :user_id }

end

