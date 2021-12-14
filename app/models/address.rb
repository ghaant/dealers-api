class Address < ApplicationRecord
  belongs_to :dealer

  validates :street, presence: true
  validates :city, presence: true
  validates :zipcode, presence: true
  validates :country, presence: true
  validates :latitude, numericality: true
  validates :longitude, numericality: true

  scope :current_addresses, lambda {
    joins(
      <<~SQL
        INNER JOIN (
                    SELECT
                      id,
                      ROW_NUMBER() OVER(PARTITION BY dealer_id) AS row_num
                    FROM addresses
                    ) a ON a.id = addresses.id
                       AND a.row_num = 1
      SQL
    )
  }
end
