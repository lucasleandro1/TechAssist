class AddUserToClients < ActiveRecord::Migration[7.0]
  def change
    add_reference :clients, :user, null: true, foreign_key: true
    
    # Se você quiser atribuir todos os clientes existentes a um usuário específico,
    # descomente e ajuste a linha abaixo:
    # execute "UPDATE clients SET user_id = 1 WHERE user_id IS NULL"
    
    # Depois de popular os dados, você pode tornar a coluna obrigatória:
    # change_column_null :clients, :user_id, false
  end
end
