class MonetizeItemCost < ActiveRecord::Migration[6.0]
  def up
    remove_column :items, :cost
    add_monetize :items, :cost

    remove_column :orders, :cost
    add_monetize :orders, :cost
  end
end
