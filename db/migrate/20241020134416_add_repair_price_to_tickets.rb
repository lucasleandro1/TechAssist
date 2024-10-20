class AddRepairPriceToTickets < ActiveRecord::Migration[7.0]
  def change
    add_column :tickets, :repair_price, :decimal, precision: 10, scale: 2
  end
end
