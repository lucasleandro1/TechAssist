class Ticket < ApplicationRecord
  belongs_to :mobile_device
  belongs_to :user

  enum status: { "Pendente" => 0, "Em andamento" => 1, "Reparo concluído" => 2, "Pedido entregue" => 3 }
  enum pecas: { "Bateria" => 0, "Tela" => 1, "Placa Sub" => 2 }
  enum sintoma: { "Energia" => 0, "Software" => 1, "Hardware" => 2 }

  validates :data_abertura, :data_fechamento, :descricao, :status, :sintoma, presence: true
  validates :mobile_device_id, uniqueness: { scope: [:status], message: "Ticket already exists for this device with the same status." }
end