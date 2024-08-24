class AddPecasToRegistro < ActiveRecord::Migration[7.0]
  def change
    add_column :registro, :pecas, :string
  end
end
