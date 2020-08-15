class Restaurant < ApplicationRecord
  resourcify
  include Authority::Abilities

  has_and_belongs_to_many :users
  has_many :orders
  has_many :items

  attr_encrypted :account_sid, key: :account_sid_encryption_key
  attr_encrypted :auth_token, key: :auth_token_encryption_key

  validates :name, :phone_number, :account_sid, :auth_token, presence: true

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
