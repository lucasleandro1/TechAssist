class CreateTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :tickets do |t|
      t.date :data_abertura
      t.date :data_fechamento
      t.string :descricao
      t.integer :status
      t.string :comentario
      t.integer :sintoma
      t.string :anexo
      t.integer :pecas

      t.timestamps
    end

    add_reference :tickets, :user, null: false, foreign_key: true
    add_reference :tickets, :mobile_device, null: false, foreign_key: true
  end
end
