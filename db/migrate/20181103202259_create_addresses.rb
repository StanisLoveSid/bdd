class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :address, null: false
      t.string :zipcode, null: false
      t.string :city, null: false
      t.string :phone, null: false
      t.string :country, null: false

      t.timestamps
    end
  end
end
