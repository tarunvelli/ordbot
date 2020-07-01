# frozen_string_literal: true

module InitResources
  extend ActiveSupport::Concern

  def init_restaurants
    @restaurants = current_user.restaurants
  end
end
