class IndexUnicoPorTicket < ActiveRecord::Migration[7.0]
  def change
    add_index :tickets, [:mobile_device_id, :descricao, :status], unique: true, name: 'Ticket unico por aparelho'
  end
end
#Criando um index unico para cada ticket que for criado com o mesmo mobile_device_descricao e status no banco de dados
