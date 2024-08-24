class Resgistro < ApplicationRecord
  belongs_to :aparelho
  belongs_to :user
  enum sintoma: [:bateria, :tela, :som, :hardware, :software]
end
