class CreateSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :settings do |t|
      t.decimal :total_received

      t.timestamps
    end
  end
end
