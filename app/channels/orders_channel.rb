class OrdersChannel < ApplicationCable::Channel
  def subscribed
    stream_from "orders_channel_#{params[:restaurant_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    Order.find(data['order_id']).update(state: data['state'])
  rescue StandardError
    restaurant = Restaurant.find(data['restaurant_id'])
    restaurant.broadcast_to_orders_channel
  end
end
