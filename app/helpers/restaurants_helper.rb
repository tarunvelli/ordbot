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
end
