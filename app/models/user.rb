class User < ApplicationRecord
  acts_as_paranoid
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,
         :validatable, :confirmable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  rolify
  has_many :restaurants, through: :roles, source: :resource, source_type: 'Restaurant'

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

  def role_in_resource(resource)
    self.roles.find_by(resource_id: resource.id, resource_type: resource.class.name)&.name
  end
end
