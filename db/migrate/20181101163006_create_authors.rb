class CreateAuthors < ActiveRecord::Migration[5.2]
  def change
    create_table :authors do |t|
      t.string :full_name
      t.integer :book_id

      t.timestamps
    end
  end
end
