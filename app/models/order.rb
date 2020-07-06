class Order < ApplicationRecord
  belongs_to :restaurant
  has_many :order_items
  has_many :items, through: :order_items

  after_save :broadcast_orders_channel

  private
  def broadcast_orders_channel
    ActionCable.server.broadcast("orders_channel_#{restaurant.id}", restaurant.orders)
  end
end
