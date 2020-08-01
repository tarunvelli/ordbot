class LandingpageController < ActionController::Base
  def index
    redirect_to primary_restaurant_orders if signed_in?
  end

  private

  def primary_restaurant_orders
    if current_user.restaurants.present?
      restaurant_orders_path(current_user.restaurants.first)
    else
      new_restaurant_path
    end
  end
end
