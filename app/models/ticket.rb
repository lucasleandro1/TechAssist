class Ticket < ApplicationRecord
  belongs_to :mobile_device
  belongs_to :user

  enum status: { "Em andamento" => 0, "Pendente" => 1, "Reparo concluído" => 2 }
  enum pecas: { "Bateria" => 0, "Tela" => 1, "Placa Sub" => 2 }
  enum sintoma: { "Energia" => 0, "Software" => 1, "Hardware" => 2 }


  validates :mobile_device_id, presence: true

end
