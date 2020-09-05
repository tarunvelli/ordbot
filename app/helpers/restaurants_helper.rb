module RestaurantsHelper
  def earnings_in_current_month
    today = Date.today
    month_start = today.beginning_of_month
    month_end = today.end_of_month

    @orders.where(created_at: month_start...month_end)
           .where.not(state: 'received')
           .map(&:cost).sum.to_s
  end

  def earnings_in_current_year
    today = Date.today
    year_start = today.beginning_of_year
    year_end = today.end_of_year

    @orders.where(created_at: year_start...year_end)
           .where.not(state: 'received')
           .map(&:cost).sum.to_s
  end

  def pending_orders
    @orders.where(state: 'received').count.to_s
  end

  def restaurant_users_details(users)
    users.sort_by(&:id).map do |user|
      {
        id: user.id,
        email: user.email,
        role: user.resource_role(@restaurant),
        confirmed: user.confirmed?
      }
    end
  end

  def all_currencies
    Money::Currency.table.map do |_, currency_details|
      [currency_details[:name], currency_details[:iso_code]]
    end
  end
end
