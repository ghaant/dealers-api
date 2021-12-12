class CreateDealers < ActiveRecord::Migration[6.0]
  def change
    create_table :dealers do |t|
      t.string :name, null: false
      t.bigint :phone, null: false
      t.timestamps
    end

    add_index :dealers, :name, unique: true, name: :ux_dealers_name
    add_index :dealers, :phone, unique: true, name: :ux_dealers_phone
  end
end
