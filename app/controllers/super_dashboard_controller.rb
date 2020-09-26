class SuperDashboardController < PanelController
  before_action :set_hero_metrics, only: %i[super_dashboard]
  before_action :set_monthly_signup_metrics, only: %i[super_dashboard]
  before_action :set_users_list, only: %i[super_dashboard]
  after_action :verify_authorized, only: %i[super_dashboard]

  # GET /super_dashboard
  def super_dashboard
    authorize User
  end

  def add_super_user; end

  def remove_super_user; end

  private

  def set_hero_metrics
    @orders_count = Order.where.not(state: Order::UNCONFIRMED_STATE).count
    @users_count = User.count
    @restaurants_count = Restaurant.count
  end

  def set_monthly_signup_metrics
    @users_by_month = User.group("DATE_TRUNC('month', created_at)").count
    @restaurants_by_month = Restaurant.group("DATE_TRUNC('month', created_at)").count
  end

  def set_users_list
    @users = User.order(id: :desc).map do |user|
      {
        id: user.id,
        email: user.email,
        created_at: user.created_at.to_date,
        restaurants: user.restaurants.pluck(:name)
      }
    end
  end
end
