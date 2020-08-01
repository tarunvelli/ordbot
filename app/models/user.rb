class User < ApplicationRecord
  include Authority::UserAbilities
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,
         :validatable, :confirmable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_and_belongs_to_many :restaurants

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    # Comment the section below if you dont want users to be created if they don't exist
    unless user
      user = User.new
      user.name = data['name'],
                  user.email = data['email'],
                  user.password = Devise.friendly_token[0, 20]
      user.skip_confirmation!
      user.save!
    end

    user
  end
end
