class AddPriceAndDaysToDelivery < ActiveRecord::Migration[5.2]
  def change
    add_column :deliveries, :price, :decimal, precision: 8, scale: 2
    add_column :deliveries, :max_days, :integer
    add_column :deliveries, :min_days, :integer
  end
end
