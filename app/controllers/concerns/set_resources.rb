# frozen_string_literal: true

module SetResources
  extend ActiveSupport::Concern

  def set_restaurants
    @restaurants = current_user.restaurants
  end
end
