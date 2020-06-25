class CreateRestaurantsUsersJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_join_table :restaurants, :users do |t|
      t.index :restaurant_id
      t.index :user_id
    end
  end
end
