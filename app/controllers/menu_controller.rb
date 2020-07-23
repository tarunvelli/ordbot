class MenuController < ActionController::Base
  before_action :set_restaurant

  def show
    @from = params['u']&.decrypt
    @items = @restaurant.items
  end

  private
  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end
end
