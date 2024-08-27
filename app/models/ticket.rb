class Ticket < ApplicationRecord
  belongs_to :mobile_device
  belongs_to :user

  enum status: { "Em andamento" => 1, "Pendente" => 2, "Reparo concluído" => 3 }
  enum pecas: { "Bateria" => 1, "Tela" => 2, "Placa Sub" => 3 }
  enum sintoma: { "Energia" => 1, "Software" => 2, "Hardware" => 3 }
end
