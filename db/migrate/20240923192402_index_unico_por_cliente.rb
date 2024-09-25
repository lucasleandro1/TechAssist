class IndexUnicoPorCliente < ActiveRecord::Migration[7.0]
  def change
    add_index :clients, :cpf, unique: true
  end
end
#Criando um index único a partir do cpf do cliente
