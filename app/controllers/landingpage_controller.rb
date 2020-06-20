class LandingpageController < ActionController::Base
  def index
    redirect_to primary_restaurant_orders if signed_in?
  end

  private
  def primary_restaurant_orders
    # use roles to get the restaurant
    restaurant_orders_path(restaurant_id: 1)
  end
end
