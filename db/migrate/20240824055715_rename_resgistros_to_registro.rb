class RenameResgistrosToRegistro < ActiveRecord::Migration[7.0]
  def change
    rename_table :resgistros, :registro
  end
end

