class CreateDealers < ActiveRecord::Migration[6.0]
  def change
    create_table :dealers do |t|
      t.string :name, null: false
      t.integer :phone, null: false
      t.timestamps
    end
  end
end
