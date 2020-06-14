class Order < ApplicationRecord
  belongs_to :user
  after_save :broadcast_orders_channel

  private
  def broadcast_orders_channel
    ActionCable.server.broadcast("orders_channel_#{user.id}", user.orders)
  end
end
