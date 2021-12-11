class Dealer < ApplicationRecord
  has_many :addresses, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :phone, presence: true
end
