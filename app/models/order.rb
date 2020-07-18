class Order < ApplicationRecord
  include SendMessage

  belongs_to :restaurant
  has_many :order_items
  has_many :items, through: :order_items

  after_save :broadcast_orders_channel
  after_update :send_message

  PRE_DELIVERY_STATES = ['received', 'preparing']
  PRE_DELIVERED_STATES = PRE_DELIVERY_STATES + ['delivering']

  private
  def broadcast_orders_channel
    ActionCable.server.broadcast("orders_channel_#{restaurant.id}", restaurant.orders)
  end
end
