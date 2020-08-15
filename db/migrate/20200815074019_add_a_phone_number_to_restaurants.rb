class AddAPhoneNumberToRestaurants < ActiveRecord::Migration[6.0]
  def change
    add_column :restaurants, :phone_number, :text
  end
end
