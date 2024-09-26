class IndexUnicoPorAparelho < ActiveRecord::Migration[7.0]
  def change
    add_index :mobile_devices, :imei, unique: true
  end
end
#Criando um index único baseado no imei do aparelho no banco de dados