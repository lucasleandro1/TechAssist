class Ticket < ApplicationRecord
  after_save :update_total_received, if: -> { saved_change_to_status? || saved_change_to_repair_price? }
  belongs_to :mobile_device
  belongs_to :user
  has_many_attached :arquivos
  serialize :pecas, Array
  enum status: { "Pendente" => 0, "Em andamento" => 1, "Orçamento aprovado" => 2, "Orçamento reprovado" => 3, "Pedido reprovado entregue" => 4, "Peça em transito" => 5, "Reparo concluído" => 6, "Pedido entregue" => 7}
  PECAS = { "Bateria" => 0, "Tela" => 1, "Placa Sub" => 2, "Placa mãe" => 3,
                "Camera" => 4, "Botão power" => 5, "Botão volume" => 6, "Microfone" => 7,
                "Alto-falante"=> 8, "Tampa traseira" => 9 }.freeze
  enum sintoma: { "Energia" => 0, "Software" => 1, "Hardware" => 2 }

  validates :descricao, :status, :sintoma, presence: true
  validates :mobile_device_id, uniqueness: { scope: [:status], message: "Ticket already exists for this device with the same status." }


  def close_ticket
    self.data_fechamento = Time.current
    save
  end

  def update_total_received
    total = Ticket.where(status: [2,5,6,7]).sum(:repair_price)
    setting = Setting.first_or_create
    setting.update(total_received: total)
  end

  def as_json(options = {})
    super(options).merge(
      "pecas" => pecas.map { |indice| Ticket::PECAS.key(indice) }
    )
  end
end
