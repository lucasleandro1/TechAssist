class RemoveAnexoFromTickets < ActiveRecord::Migration[7.0]
  def change
    remove_column :tickets, :anexo, :string
  end
end
