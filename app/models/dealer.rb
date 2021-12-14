class Dealer < ApplicationRecord
  has_many :addresses, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :phone, numericality: { only_integer: true }
end
