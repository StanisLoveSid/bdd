class AddInfoToBook < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :number_of_pages, :integer
    add_column :books, :publication_date, :string
  end
end
