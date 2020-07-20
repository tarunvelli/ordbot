class Order < ApplicationRecord
  include SendMessage

  belongs_to :restaurant
  has_many :order_items
  has_many :items, through: :order_items

  validates :from, :address, presence: true

  before_validation :calculate_cost
  after_create :send_confirmation_request
  after_update :send_message
  after_save :broadcast_orders_channel

  PRE_DELIVERY_STATES = ['received', 'preparing']
  PRE_DELIVERED_STATES = PRE_DELIVERY_STATES + ['delivering']

  def order_details
    {
      id: id,
      state: state,
      created_at: created_at,
      cost: cost,
      note: note,
      address: address,
      items: items_details
    }
  end

  def items_details
    order_items.map do |order_item|
      {
        quantity: order_item.quantity,
        name: order_item.item.name,
        id: order_item.id
      }
    end
  end

  private
  def broadcast_orders_channel
    ActionCable.server.broadcast("orders_channel_#{restaurant.id}", restaurant.orders.map(&:order_details))
  end

  def calculate_cost
    total_cost = 0
    order_items.each do |order_item|
      total_cost += order_item.quantity * order_item.item.cost
    end
    self.assign_attributes(cost: total_cost)
  end
end
