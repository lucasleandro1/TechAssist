class CreateMobileDevices < ActiveRecord::Migration[7.0]
  def change
    create_table :mobile_devices do |t|
      t.string :imei
      t.string :serial
      t.string :modelo
      t.string :marca

      t.timestamps
    end

    add_reference :mobile_devices, :client, null: false, foreign_key: true
  end
end
