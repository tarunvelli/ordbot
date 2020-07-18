class OrdersChannel < ApplicationCable::Channel
  def subscribed
    stream_from "orders_channel_#{params[:restaurant_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    begin
      Order.find(data['order_id']).update(state: data['state'])
    rescue
      restaurant = Restaurant.find(data['restaurant_id'])
      ActionCable.server.broadcast("orders_channel_#{restaurant.id}", restaurant.orders)
    end
  end
end
