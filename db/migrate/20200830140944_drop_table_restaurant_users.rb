class DropTableRestaurantUsers < ActiveRecord::Migration[6.0]
  def change
    def up
      drop_table :restaurants_users
    end

    def down
      raise ActiveRecord::IrreversibleMigration
    end
  end
end
