class MenuController < ActionController::Base
  before_action :set_restaurant

  def show
    @from = params['u']&.decrypt
    @items = @restaurant.items.map(&:item_details)
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end
end
