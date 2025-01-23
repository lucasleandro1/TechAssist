class RemovePecasFromTickets < ActiveRecord::Migration[7.0]
  def change
    remove_column :tickets, :pecas, :text, array: true, default: []
  end
end
