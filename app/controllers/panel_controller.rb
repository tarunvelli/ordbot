class PanelController < ActionController::Base
  include Pundit
  include SetResources

  before_action :authenticate_user!
  before_action :set_restaurants

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def home
    redirect_to primary_restaurant_orders
  end

  def user_not_authorized(_exception)
    respond_to do |format|
      format.html { redirect_back(fallback_location: '/home', notice: 'Access denied') }
      format.json { render json: { error: { message: 'Access denied' } }, status: :forbidden }
    end
  end

  private

  def primary_restaurant_orders
    if !signed_in?
      root_path
    elsif current_user.restaurants.present?
      restaurant_orders_path(current_user.restaurants.first)
    else
      new_restaurant_path
    end
  end
end
