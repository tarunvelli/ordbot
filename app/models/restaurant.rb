class Restaurant < ApplicationRecord
  resourcify
  has_many :users, through: :roles

  has_many :orders
  has_many :items

  attr_encrypted :account_sid, key: :account_sid_encryption_key
  attr_encrypted :auth_token, key: :auth_token_encryption_key

  validates :name, :phone_number, :account_sid, :auth_token, presence: true

  def add_admin(user)
    user.add_role(:admin, self)
  end

  private

  def account_sid_encryption_key
    # do some fancy logic and returns an encryption key?
    ENV['ACCOUNT_SID_ENCRYPTION_KEY']
  end

  def auth_token_encryption_key
    # do some fancy logic and returns an encryption key?
    ENV['AUTH_TOEKN_ENCRYPTION_KEY']
  end
end
