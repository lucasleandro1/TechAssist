class CreateResgistros < ActiveRecord::Migration[7.0]
  def change
    create_table :resgistros do |t|
      t.string :data_abertura
      t.string :data_fechamento
      t.string :descricao
      t.string :status
      t.string :comentario
      t.string :sintoma
      t.string :anexo
      t.references :aparelho, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
