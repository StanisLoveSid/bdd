class CreateCovers < ActiveRecord::Migration[5.2]
  def change
    create_table :covers do |t|
      t.references :book, foreign_key: true
      t.string :file

      t.timestamps
    end
  end
end
