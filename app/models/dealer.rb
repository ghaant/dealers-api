class Dealer < ApplicationRecord
  has_many :addresses, dependent: :destroy
end
