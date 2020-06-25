class LandingpageController < ActionController::Base
  def index
    redirect_to primary_restaurant_orders if signed_in?
  end

  private
  def primary_restaurant_orders
    restaurant_orders_path(current_user.restaurants.first)
  end
end
