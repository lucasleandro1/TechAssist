class UpdateCpfUniqueIndex < ActiveRecord::Migration[7.0]
  def change
    # Remove o índice único atual do CPF
    remove_index :clients, :cpf
    
    # Adiciona novo índice único composto por CPF e user_id
    add_index :clients, [:cpf, :user_id], unique: true
  end
end
