module SuperDashboardHelper
  def monthly_signups(users_by_month, restaurants_by_month, orders_by_month)
    12.times.map do |i|
      month = (DateTime.now.utc - i.month).beginning_of_month
      {
        name: month.strftime('%b %Y'),
        users: users_by_month[month] || 0,
        restaurants: restaurants_by_month[month] || 0,
        orders: orders_by_month[month] || 0
      }
    end.reverse
  end
end
