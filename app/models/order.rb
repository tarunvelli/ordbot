class Order < ApplicationRecord
  include SendMessage

  belongs_to :restaurant
  has_many :order_items
  has_many :items, through: :order_items

  validates :from, :address, presence: true
  monetize :cost_cents

  before_validation :calculate_cost
  after_create :send_confirmation_request
  after_update :send_order_update, if: :saved_change_to_state?
  after_save :broadcast_restaurant_orders_channel

  UNCONFIRMED_STATE = 'unconfirmed'.freeze
  PRE_DELIVERY_STATES = %w[received preparing].freeze
  PRE_DELIVERED_STATES = PRE_DELIVERY_STATES + ['delivering']
  VALID_STATES = PRE_DELIVERED_STATES + ['delivered'] + [UNCONFIRMED_STATE]

  validates :state, inclusion: { in: VALID_STATES }

  def order_details
    {
      id: id,
      state: state,
      created_at: created_at,
      cost: cost.amount.to_f,
      display_cost: cost.format,
      note: note,
      address: address,
      items: order_items_details
    }
  end

  def order_items_details
    order_items.map do |order_item|
      {
        quantity: order_item.quantity,
        name: order_item.item.name,
        id: order_item.id
      }
    end
  end

  private

  def broadcast_restaurant_orders_channel
    restaurant.broadcast_to_orders_channel
  end

  def calculate_cost
    total_cost = 0
    order_items.each do |order_item|
      total_cost += order_item.quantity * order_item.item.cost.amount
    end
    unless persisted?
      assign_attributes(
        cost_currency: restaurant.currency,
        state: UNCONFIRMED_STATE
      )
    end
    assign_attributes(cost: total_cost)
  end
end
