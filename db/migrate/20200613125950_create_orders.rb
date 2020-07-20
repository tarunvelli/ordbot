class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :from
      t.text :note
      t.float :cost
      t.string :state
      t.text :address

      t.timestamps
    end
  end
end
