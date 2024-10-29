class AddPecasToTickets < ActiveRecord::Migration[7.0]
  def change
    add_column :tickets, :pecas, :text
  end
end
