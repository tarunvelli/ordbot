# frozen_string_literal: true

module RestaurantUsers
  extend ActiveSupport::Concern

  def set_restaurant_user
    @restaurant_user = User.find(params[:user_id])
  end

  def set_new_or_existing_user
    @restaurant_user = User.find_by(email: params[:user_email])
    @restaurant_user = User.invite!({ email: params[:user_email] }, current_user) if @restaurant_user.nil?
  end

  def restaurant_users_response
    render json: {
      restaurant_users: helpers.restaurant_users_details(@restaurant.users)
    }
  end
end
