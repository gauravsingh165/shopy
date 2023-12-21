class AddProductIdToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :product_ids, :integer, array: true, default: []
    add_reference :orders, :user, null: false, foreign_key: true
    add_column :orders, :address, :string
    add_column :orders, :phone, :integer
  end
end
