class Order < ApplicationRecord
  belongs_to :restaurant
  after_save :broadcast_orders_channel

  private
  def broadcast_orders_channel
    ActionCable.server.broadcast("orders_channel_#{restaurant.id}", restaurant.orders)
  end
end
