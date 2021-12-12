class Address < ApplicationRecord
  belongs_to :dealer

  validates :street, presence: true
  validates :city, presence: true
  validates :zipcode, presence: true
  validates :country, presence: true
  validates :latitude, presence: true, numericality: true
  validates :longitude, presence: true, numericality: true

  scope :current_addresses, lambda {
    joins(
      <<~SQL
        INNER JOIN (
                    SELECT a.id
                    FROM (
                          SELECT id, ROW_NUMBER() OVER(PARTITION BY dealer_id) AS row_num
                          FROM addresses
                          ) a
                    WHERE a.row_num = 1
                    ) ca ON ca.id = addresses.id
      SQL
    )
  }
end
