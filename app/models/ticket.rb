class Ticket < ApplicationRecord
  belongs_to :mobile_device
  belongs_to :user
  has_many_attached :arquivos
  enum status: { "Pendente" => 0, "Em andamento" => 1, "Peça em transito" => 2, "Reparo concluído" => 3, "Pedido entregue" => 4 }
  enum pecas: { "Bateria" => 0, "Tela" => 1, "Placa Sub" => 2, "Placa mãe" => 3,
                "Camera" => 4, "Botão power" => 5, "Botão volume" => 6, "Microfone" => 7,
                "Alto-falante"=> 8, "Tampa traseira" => 9 }
  enum sintoma: { "Energia" => 0, "Software" => 1, "Hardware" => 2 }

  validates :descricao, :status, :sintoma, presence: true
  validates :mobile_device_id, uniqueness: { scope: [:status], message: "Ticket already exists for this device with the same status." }
end