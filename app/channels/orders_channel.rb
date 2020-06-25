class OrdersChannel < ApplicationCable::Channel
  def subscribed
    stream_from "orders_channel_#{params[:restaurant_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
