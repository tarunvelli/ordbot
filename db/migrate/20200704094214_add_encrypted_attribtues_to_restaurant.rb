class AddEncryptedAttribtuesToRestaurant < ActiveRecord::Migration[6.0]
  def change
    add_column :restaurants, :encrypted_account_sid, :string
    add_column :restaurants, :encrypted_account_sid_iv, :string

    add_column :restaurants, :encrypted_auth_token, :string
    add_column :restaurants, :encrypted_auth_token_iv, :string

    add_index :restaurants, :encrypted_account_sid_iv, unique: true
    add_index :restaurants, :encrypted_auth_token_iv, unique: true
  end
end
