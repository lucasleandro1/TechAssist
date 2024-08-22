class CreateClientes < ActiveRecord::Migration[7.0]
  def change
    create_table :clientes do |t|
      t.string :cpf
      t.string :nome
      t.string :telefone
      t.string :email

      t.timestamps
    end
  end
end
