class RemoveReceivedFromTickets < ActiveRecord::Migration[7.0]
  def change
    remove_column :tickets, :received, :decimal
  end
end
