class AddImportantInfoToBook < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :price, :decimal, precision: 8, scale: 2
    add_column :books, :publication_year, :integer
    add_column :books, :materials, :string
    add_column :books, :height, :float
    add_column :books, :width, :float
  end
end
