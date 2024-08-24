class MobileDevice < ApplicationRecord
  belongs_to :client

  has_many :tickets
end
