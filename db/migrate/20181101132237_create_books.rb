class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.string :authors
      t.integer :author_id
      t.integer :category_id

      t.timestamps
    end
  end
end
