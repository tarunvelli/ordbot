class AddAddressToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :address, :text
  end
end
