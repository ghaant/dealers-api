class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.references :dealer, null: false, index: { name: :id_addresses_dealer_id }
      t.string :street, null: false
      t.string :city, null: false
      t.string :zipcode, null: false
      t.string :country, null: false
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.timestamps
    end

    add_foreign_key :addresses, :dealers, name: :fk_addresses_dealer_id
    add_index :addresses, :city, name: :ix_addresses_city
    add_index :addresses, :country, name: :ix_addresses_country
    add_index :addresses, :zipcode, name: :ix_addresses_zipcode
  end
end
