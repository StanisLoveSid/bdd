class AddPolymorphicColoumnsToAddress < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :addressable_type, :string, index: true
    add_column :addresses, :addressable_id, :integer, index: true
    add_column :addresses, :addressable_scope, :string, index: true
  end
end
