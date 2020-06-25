class Restaurant < ApplicationRecord
  resourcify
  include Authority::Abilities

  has_and_belongs_to_many :users
  has_many :orders
end
