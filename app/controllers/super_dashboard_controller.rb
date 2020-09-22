class SuperDashboardController < PanelController
  after_action :verify_authorized, only: %i[super_dashboard]

  # GET /super_dashboard
  def super_dashboard
    authorize User

    @orders_count = Order.where.not(state: Order::UNCONFIRMED_STATE).count
    @users_count = User.count
    @restaurants_count = Restaurant.count

    @users = User.order(id: :desc).map do |user|
      { id: user.id, email: user.email, restaurants: user.restaurants.pluck(:name) }
    end
    @users_by_month = User.group("DATE_TRUNC('month', created_at)").count
  end

  def add_super_user; end

  def remove_super_user; end
end
